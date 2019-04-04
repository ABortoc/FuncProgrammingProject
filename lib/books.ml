let connection_url = "postgresql://postgres:1990@localhost:5432/Books"

(* This is the connection pool we will use for executing DB operations. *)
let pool =
  match Caqti_lwt.connect_pool ~max_size:10 (Uri.of_string connection_url) with
  | Ok pool -> pool
  | Error err -> failwith (Caqti_error.show err)

type book = {
  book_id: int;
  author: string;
  title: string;
}

type error =
  | Database_error of string

(* Helper method to map Caqti errors to our own error type. 
   val or_error : ('a, [> Caqti_error.t ]) result Lwt.t -> ('a, error) result Lwt.t *)
let or_error m =
  match%lwt m with
  | Ok a -> Ok a |> Lwt.return
  | Error e -> Error (Database_error (Caqti_error.show e)) |> Lwt.return

let migrate_query =
  Caqti_request.exec
    Caqti_type.unit
    {| CREATE TABLE read (
          book_id SERIAL NOT NULL PRIMARY KEY,
          author VARCHAR NOT NULL,
          title VARCHAR NOT NULL UNIQUE
       )
    |}

let migrate () =
  let migrate' (module C : Caqti_lwt.CONNECTION) =
    C.exec migrate_query ()
  in
  Caqti_lwt.Pool.use migrate' pool |> or_error


let rollback_query =
  Caqti_request.exec
    Caqti_type.unit
    "DROP TABLE read"

let rollback () =
  let rollback' (module C : Caqti_lwt.CONNECTION) =
    C.exec rollback_query ()
  in
  Caqti_lwt.Pool.use rollback' pool |> or_error
  

(* Stub these out for now. *)
let get_all_query =
  Caqti_request.collect
    Caqti_type.unit
    Caqti_type.(tup3 int string string)
    "SELECT book_id, author, title FROM read"

let get_all () =
  let get_all' (module C : Caqti_lwt.CONNECTION) =
    C.fold get_all_query (fun (book_id, author, title) acc ->
        { book_id; author; title } :: acc
      ) () []
  in
  Caqti_lwt.Pool.use get_all' pool |> or_error

let add_query =
  Caqti_request.exec
    Caqti_type.(tup2 string string)
    "INSERT INTO read (author, title) VALUES (?, ?)"

let add author title =
  let add' author title (module C : Caqti_lwt.CONNECTION) =
    C.exec add_query (author, title)
  in
  Caqti_lwt.Pool.use (add' author title) pool |> or_error

let remove_query =
  Caqti_request.exec
    Caqti_type.int
    "DELETE FROM read WHERE book_id = ?"

let remove book_id =
  let remove' book_id (module C : Caqti_lwt.CONNECTION) =
    C.exec remove_query book_id
  in
  Caqti_lwt.Pool.use (remove' book_id) pool |> or_error

let clear_query =
  Caqti_request.exec
    Caqti_type.unit
    "TRUNCATE TABLE read"

let clear () =
  let clear' (module C : Caqti_lwt.CONNECTION) =
    C.exec clear_query ()
  in
  Caqti_lwt.Pool.use clear' pool |> or_error
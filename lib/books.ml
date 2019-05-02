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
  date: string;
}

type error =
  | Database_error of string

(* Helper method to map Caqti errors to our own error type. 
   val or_error : ('a, [> Caqti_error.t ]) result Lwt.t -> ('a, error) result Lwt.t *)
let or_error m =
  match%lwt m with
  | Ok a -> Ok a |> Lwt.return
  | Error e -> Error (Database_error (Caqti_error.show e)) |> Lwt.return

let migrate_read_query =
  Caqti_request.exec
    Caqti_type.unit
    {| CREATE TABLE read (
          book_id SERIAL NOT NULL PRIMARY KEY,
          author VARCHAR NOT NULL,
          title VARCHAR NOT NULL UNIQUE,
          date VARCHAR NOT NULL
       )
    |}

let migrate_read () =
  let migrate' (module C : Caqti_lwt.CONNECTION) =
    C.exec migrate_read_query ()
  in
  Caqti_lwt.Pool.use migrate' pool |> or_error


let rollback_read_query =
  Caqti_request.exec
    Caqti_type.unit
    "DROP TABLE read"

let rollback_read () =
  let rollback' (module C : Caqti_lwt.CONNECTION) =
    C.exec rollback_read_query ()
  in
  Caqti_lwt.Pool.use rollback' pool |> or_error
  

let get_all_read_query =
  Caqti_request.collect
    Caqti_type.unit
    Caqti_type.(tup4 int string string string)
    "SELECT book_id, author, title, date FROM read"

let get_all_read () =
  let get_all' (module C : Caqti_lwt.CONNECTION) =
    C.fold get_all_read_query (fun (book_id, author, title, date) acc ->
        { book_id; author; title; date } :: acc
      ) () []
  in
  Caqti_lwt.Pool.use get_all' pool |> or_error

let add_read_query =
  Caqti_request.exec
    Caqti_type.(tup3 string string string)
    "INSERT INTO read (author, title, date) VALUES (?, ?, ?)"

let add_read author title date =
  let add' author title date (module C : Caqti_lwt.CONNECTION) =
    C.exec add_read_query (author, title, date)
  in
  Caqti_lwt.Pool.use (add' author title date) pool |> or_error

let remove_read_query =
  Caqti_request.exec
    Caqti_type.int
    "DELETE FROM read WHERE book_id = ?"

let remove_read book_id =
  let remove' book_id (module C : Caqti_lwt.CONNECTION) =
    C.exec remove_read_query book_id
  in
  Caqti_lwt.Pool.use (remove' book_id) pool |> or_error

let clear_read_query =
  Caqti_request.exec
    Caqti_type.unit
    "TRUNCATE TABLE read"

let clear_read () =
  let clear' (module C : Caqti_lwt.CONNECTION) =
    C.exec clear_read_query ()
  in
  Caqti_lwt.Pool.use clear' pool |> or_error



let migrate_toread_query =
  Caqti_request.exec
    Caqti_type.unit
    {| CREATE TABLE toread (
          book_id SERIAL NOT NULL PRIMARY KEY,
          author VARCHAR NOT NULL,
          title VARCHAR NOT NULL UNIQUE,
          date VARCHAR NOT NULL
       )
    |}

let migrate_toread () =
  let migrate' (module C : Caqti_lwt.CONNECTION) =
    C.exec migrate_toread_query ()
  in
  Caqti_lwt.Pool.use migrate' pool |> or_error


let rollback_toread_query =
  Caqti_request.exec
    Caqti_type.unit
    "DROP TABLE toread"

let rollback_toread () =
  let rollback' (module C : Caqti_lwt.CONNECTION) =
    C.exec rollback_toread_query ()
  in
  Caqti_lwt.Pool.use rollback' pool |> or_error
  

let get_all_toread_query =
  Caqti_request.collect
    Caqti_type.unit
    Caqti_type.(tup4 int string string string)
    "SELECT book_id, author, title, date FROM toread"

let get_all_toread () =
  let get_all' (module C : Caqti_lwt.CONNECTION) =
    C.fold get_all_toread_query (fun (book_id, author, title, date) acc ->
        { book_id; author; title; date } :: acc
      ) () []
  in
  Caqti_lwt.Pool.use get_all' pool |> or_error

let add_toread_query =
  Caqti_request.exec
    Caqti_type.(tup3 string string string)
    "INSERT INTO toread (author, title, date) VALUES (?, ?, ?)"

let add_toread author title date =
  let add' author title date (module C : Caqti_lwt.CONNECTION) =
    C.exec add_toread_query (author, title, date)
  in
  Caqti_lwt.Pool.use (add' author title date) pool |> or_error

let remove_toread_query =
  Caqti_request.exec
    Caqti_type.int
    "DELETE FROM toread WHERE book_id = ?"

let remove_toread book_id =
  let remove' book_id (module C : Caqti_lwt.CONNECTION) =
    C.exec remove_toread_query book_id
  in
  Caqti_lwt.Pool.use (remove' book_id) pool |> or_error

let clear_toread_query =
  Caqti_request.exec
    Caqti_type.unit
    "TRUNCATE TABLE toread"

let clear_toread () =
  let clear' (module C : Caqti_lwt.CONNECTION) =
    C.exec clear_toread_query ()
  in
  Caqti_lwt.Pool.use clear' pool |> or_error

let print_book bk =
  Printf.printf "%s " bk.author;
  Printf.printf "%s " bk.title;
  Printf.printf "%s\n" bk.date;
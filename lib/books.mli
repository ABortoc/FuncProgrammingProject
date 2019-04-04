type book = {
  book_id: int;
  author: string;
  title: string;
}

type error =
  | Database_error of string

(* Migrations-related helper functions. *)
val migrate : unit -> (unit, error) result Lwt.t
val rollback : unit -> (unit, error) result Lwt.t

(* Core functions *)
val get_all : unit -> (book list, error) result Lwt.t
val add : string -> string -> (unit, error) result Lwt.t
val remove : int -> (unit, error) result Lwt.t
val clear : unit -> (unit, error) result Lwt.t
type book = {
  book_id: int;
  author: string;
  title: string;
  date: string;
}

type error =
  | Database_error of string

(* Migrations-related helper functions. *)
val migrate_read : unit -> (unit, error) result Lwt.t
val rollback_read : unit -> (unit, error) result Lwt.t
val migrate_toread : unit -> (unit, error) result Lwt.t
val rollback_toread : unit -> (unit, error) result Lwt.t

(* Core functions *)
val get_all_read : unit -> (book list, error) result Lwt.t
val add_read : string -> string -> string -> (unit, error) result Lwt.t
val remove_read : int -> (unit, error) result Lwt.t
val clear_read : unit -> (unit, error) result Lwt.t
val get_all_toread : unit -> (book list, error) result Lwt.t
val add_toread : string -> string -> string -> (unit, error) result Lwt.t
val remove_toread : int -> (unit, error) result Lwt.t
val clear_toread : unit -> (unit, error) result Lwt.t
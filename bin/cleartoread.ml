open Lib

let clear_toread () =
  print_endline "Removing all books from toread table.";
  match%lwt Books.clear_toread () with
  | Ok () -> print_endline "Removed all books." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (clear_toread ())
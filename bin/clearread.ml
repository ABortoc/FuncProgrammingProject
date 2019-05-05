open Lib

let clear_read () =
  print_endline "Removing all books from read table.";
  match%lwt Books.clear_read () with
  | Ok () -> print_endline "Removed all books." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (clear_read ())
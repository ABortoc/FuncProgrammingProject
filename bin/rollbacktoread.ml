open Lib

let rollback_toread () =
  print_endline "Dropping toread table.";
  match%lwt Books.rollback_toread () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (rollback_toread ())
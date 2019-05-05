open Lib

let migrate_read () =
  print_endline "Creating read table.";
  match%lwt Books.migrate_read () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (migrate_read ())
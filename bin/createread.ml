open Lib

let create_read () =
  print_endline "Creating read table.";
  match%lwt Books.create_read () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (create_read ())
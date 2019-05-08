open Lib

let create_toread () =
  print_endline "Creating toread table.";
  match%lwt Books.create_toread () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (create_toread ())
open Lib

let drop_toread () =
  print_endline "Dropping toread table.";
  match%lwt Books.drop_toread () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (drop_toread ())
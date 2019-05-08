open Lib

let drop_read () =
  print_endline "Dropping read table.";
  match%lwt Books.drop_read () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (drop_read ())
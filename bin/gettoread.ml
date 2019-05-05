open Lib

let get_toread () =
  print_endline "Getting all books from toread table.";
  match%lwt Books.get_all_toread () with
  | Ok ls -> (List.iter (fun b -> Books.print_book b) ls) |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (get_toread ())
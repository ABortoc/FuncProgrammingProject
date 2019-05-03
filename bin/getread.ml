open Lib

let getread () =
  print_endline "Getting all books from read table.";
  match%lwt Books.get_all_read () with
  | Ok ls -> (List.iter (fun b -> Books.print_book b) ls) |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (getread ())
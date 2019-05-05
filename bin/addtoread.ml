open Lib

let add_toread author title date =
  print_endline "Adding a book to toread table.";
  match%lwt Books.add_toread author title date  with
  | Ok () -> print_endline "Book added" |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = 
  let arguments = Array.to_list Sys.argv in
  let author = List.nth arguments 1 in
  let title = List.nth arguments 2 in
  let date = List.nth arguments 3 in
  (*Printf.printf "%s %s %s\n" author title date*)
  Lwt_main.run (add_toread author title date)
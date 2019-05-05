open Lib

let remove_read id =
  print_endline "Removing a book from read table.";
  match%lwt Books.remove_read id with
  | Ok () -> print_endline "Removed." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = 
  let arguments = Array.to_list Sys.argv in
  let id = List.nth arguments 1 in 
  Lwt_main.run (remove_read (int_of_string id))
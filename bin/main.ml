open Lib

let get_read () =
  print_endline "Getting all books from read table.";
  match%lwt Books.get_all_read () with
  | Ok ls -> (List.iter (fun b -> Books.print_book b) ls) |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let add_read author title date =
  print_endline "Adding a book to read table.";
  match%lwt Books.add_read author title date  with
  | Ok () -> print_endline "Book added" |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let remove_read id =
  print_endline "Removing a book from read table.";
  match%lwt Books.remove_read id with
  | Ok () -> print_endline "Removed." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let clear_read () =
  print_endline "Removing all books from read table.";
  match%lwt Books.clear_read () with
  | Ok () -> print_endline "Removed all books." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let create_read () =
  print_endline "Creating read table.";
  match%lwt Books.create_read () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let drop_read () =
  print_endline "Dropping read table.";
  match%lwt Books.drop_read () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let get_toread () =
  print_endline "Getting all books from toread table.";
  match%lwt Books.get_all_toread () with
  | Ok ls -> (List.iter (fun b -> Books.print_book b) ls) |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let add_toread author title date =
  print_endline "Adding a book to toread table.";
  match%lwt Books.add_toread author title date  with
  | Ok () -> print_endline "Book added" |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let remove_toread id =
  print_endline "Removing a book from toread table.";
  match%lwt Books.remove_toread id with
  | Ok () -> print_endline "Removed." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let clear_toread () =
  print_endline "Removing all books from toread table.";
  match%lwt Books.clear_toread () with
  | Ok () -> print_endline "Removed all books." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let create_toread () =
  print_endline "Creating toread table.";
  match%lwt Books.create_toread () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let drop_toread () =
  print_endline "Dropping toread table.";
  match%lwt Books.drop_toread () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Books.Database_error msg) -> print_endline msg |> Lwt.return

let () = 
  let arguments = Array.to_list Sys.argv in
  match List.nth arguments 1 with
  | "getread" -> Lwt_main.run (get_read ())
  | "addread" -> begin let author = List.nth arguments 2 in
        let title = List.nth arguments 3 in
        let date = List.nth arguments 4 in
        Lwt_main.run (add_read author title date)
    end
  | "removeread" -> let id = List.nth arguments 2 in 
        Lwt_main.run (remove_read (int_of_string id))
  | "clearread" -> Lwt_main.run (clear_read ())
  | "createread" -> Lwt_main.run (create_read ())
  | "dropread" -> Lwt_main.run (drop_read ())
  | "gettoread" -> Lwt_main.run (get_toread ())
  | "addtoread" -> begin let author = List.nth arguments 2 in
        let title = List.nth arguments 3 in
        let date = List.nth arguments 4 in
        Lwt_main.run (add_toread author title date)
    end
  | "removetoread" -> let id = List.nth arguments 2 in 
        Lwt_main.run (remove_toread (int_of_string id))
  | "cleartoread" -> Lwt_main.run (clear_toread ())
  | "createtoread" -> Lwt_main.run (create_toread ())
  | "droptoread" -> Lwt_main.run (drop_toread ())
  | _ -> print_endline "Argument missing/Wrong Argument"
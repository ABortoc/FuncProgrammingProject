# Bookshelf  
Bookshelf is a relatively simple project in OCaml that allows the user to add, remove and print out books stored on two "shelves": read and to read. Data is stored in a Postgres database. All the functions that manipulate the database are built as standalone executables.  

**Requirements/Installation**  
Requires: Ocaml, Opam, PostgreSQL, libpq-dev  
To install Caqti and all other necessary packages, clone the repository and run: "opam pin add FuncProgrammingProject/"  
Furthermore postgres password needs to be set. To set the password: "sudo -u postgres psql", "\password postgres"  
The project uses password "1990", it can be editted to the desired password in Books.ml  
Run db_script, build_script, move_script. If everything worked, executables folder should have been created with all the  
executables inside it.  

db_script will create a database in postgres  
build_script will build executables  
move_script will create an executables folder and move all the executables into it

**createread/createtoread** - creates respective tables in the database  
**dropread/droptoread** - drops respective tables from the database  
**getread/gettoread** - retrieves and prints to the console information on all the books from the respective tables  
**addread/addtoread** - adds a book to the respective table, takes 3 strings (Author, Title, Date) as arguments in the command line  
**removeread/removetoread** - removes a book from the respective table, takes 1 int(Book ID) as an argument in the command line, ID can be looked up from the getread function  
**clearread/cleartoread** - removes all books from the respective table, preserves the table  

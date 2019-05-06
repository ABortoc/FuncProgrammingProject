Bookshelf is a relatively simple project in OCaml that allows the user to add, remove and print out books stored on two "shelves": read and to read. Data is stored in a Postgres database. All the functions that manipulate the database are built as standalone executables.

build_script will build executables
move_script will create an executables folder and move all the executables into it

migrateread/migratetoread - creates respective tables in the database
rollbackread/rollbacktoread - drops respective tables from the database
getread/gettoread - retrieves and prints to the console information on all the books from the respective tables
addread/addtoread - adds a book to the respective table, takes 3 strings (Author, Title, Date) as arguments in the command line
removeread/removetoread - removes a book from the respective table, takes 1 int(Book ID) as an argument in the command line, ID can be looked up from the getread function
clearread/cleartoread - removes all books from the respective table, preserves the table
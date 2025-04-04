(** CSV processing functions (impure I/O operations) *)

(** CSV data is represented as a list of rows, where each row is a list of strings. *)
type csv_data = string list list

(** Read CSV file from disk.
    Exits the program on error.
    @param filename Path to the CSV file
    @return List of string lists representing CSV rows
*)
val read_csv : string -> csv_data

(** Filter out empty rows from CSV data.
    An empty row is one with no cells or only cells containing empty strings.
    @param csv_data List of string lists representing CSV rows
    @return Filtered list without empty rows
*)
val filter_empty_rows : csv_data -> csv_data

(** Count rows in CSV data.
    @param csv_data List of string lists representing CSV rows
    @return Number of rows
*)
val count_rows : csv_data -> int

(** Write CSV data to file.
    Exits the program on error.
    @param filename Output file path
    @param headers List of column headers (a single row)
    @param data List of data rows (list of lists of strings)
*)
val write_csv : string -> string list -> string list list -> unit
(** CSV processing functions (impure I/O operations) *)
type csv_data = string list list

(** Read CSV file from disk
    @param filename Path to the CSV file
    @return List of string lists representing CSV rows
    @raise Failure if the file cannot be read
*)
let read_csv filename =
  try
    Csv.load filename
  with _ -> 
    Printf.eprintf "Error: Could not read CSV file %s\n" filename;
    exit 1

(** Filter out empty rows from CSV data
    @param csv_data List of string lists representing CSV rows
    @return Filtered list of string lists with non-empty rows
    @raise Failure if the CSV data is empty
*)
let filter_empty_rows csv_data =
  List.filter (fun row -> List.length row > 0 && List.exists (fun cell -> String.length cell > 0) row) csv_data

(** Count rows in CSV data
    @param csv_data List of string lists representing CSV rows
    @return Number of rows in the CSV data
*)
let count_rows csv_data =
  List.length csv_data

(** Write CSV data to file
    @param filename Path to the output CSV file
    @param headers List of headers for the CSV file
    @param data List of string lists representing CSV rows
    @raise Failure if writing to file fails
*)
let write_csv filename headers data =
  try
    Csv.save filename (headers :: data)
  with _ ->
    Printf.eprintf "Error: Could not write to CSV file %s\n" filename;
    exit 1
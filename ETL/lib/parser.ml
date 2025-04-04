(** Pure functions for transforming CSV data to records *)

open Types

(** Convert a CSV row to an order record
    @param row List of strings representing a CSV row
    @return Order record
    @raise Failure if row format is invalid
*)
let csv_to_order row =
  match row with
  | id :: client_id :: order_date :: status :: origin :: [] ->
    (try {
      id = int_of_string id;
      client_id = int_of_string client_id;
      order_date;
      status;
      origin;
    } with _ -> 
      failwith ("Invalid data in row: " ^ String.concat ", " row))
  | _ -> 
    failwith ("Invalid order row format: " ^ String.concat ", " row)

(** Convert a CSV row to an order_item record *)
let csv_to_order_item row =
  match row with
  | order_id :: product_id :: quantity :: price :: tax :: [] ->
    (try {
      order_id = int_of_string order_id;
      product_id = int_of_string product_id;  (* This should be creating an order_item *)
      quantity = int_of_string quantity;
      price = float_of_string price;
      tax = float_of_string tax;
    } with _ -> 
      failwith ("Invalid data in row: " ^ String.concat ", " row))
  | _ -> 
    failwith ("Invalid row format: " ^ String.concat ", " row)

(** Convert a list of CSV rows to a list of order records
    @param rows List of string lists representing CSV rows
    @return List of order records
*)
let csv_rows_to_orders rows =
  (* Skip header row if present *)
  let data_rows = if List.length rows > 0 then List.tl rows else [] in
  List.map csv_to_order data_rows

(** Convert a list of CSV rows to a list of order_item records
    @param rows List of string lists representing CSV rows
    @return List of order_item records
*)
let csv_rows_to_order_items rows =
  (* Skip header row *)
  match rows with
  | [] -> []
  | _ :: data_rows -> List.map csv_to_order_item data_rows
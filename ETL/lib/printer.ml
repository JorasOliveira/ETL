(** Printing utilities for displaying ETL data *)

open Types
open Csv_processor

(** Print a list of orders to the console in a formatted table *)
let print_orders (orders : order list) =
  Printf.printf "\n===== ORDERS =====\n";
  Printf.printf "%-5s %-10s %-20s %-10s %-8s\n" 
    "ID" "CLIENT_ID" "ORDER_DATE" "STATUS" "ORIGIN";
  Printf.printf "%s\n" (String.make 60 '-');
  
  List.iter (fun order ->
    Printf.printf "%-5d %-10d %-20s %-10s %-8s\n" 
      order.id
      order.client_id
      order.order_date
      order.status
      order.origin
  ) orders

(** Print a list of order items with all details *)
let print_order_items (items : order_item list) : unit =
  Printf.printf "\n===== ORDER ITEMS =====\n";
  (* Define header format - adjust spacing as needed *)
  Printf.printf "%-10s %-12s %-10s %-12s %-12s\n"
    "ORDER_ID" "PRODUCT_ID" "QUANTITY" "PRICE" "TAX";
  (* Print separator line matching the header width *)
  Printf.printf "%s\n" (String.make 60 '-'); (* Adjust length (10+12+10+12+12 + spaces) *)

  List.iter (fun (item : Types.order_item) -> (* Keep the explicit type annotation for safety *)
    Printf.printf "%-10d %-12d %-10d %-12.2f %-12.2f\n"
      item.order_id
      item.product_id
      item.quantity
      item.price  (* Use %.2f for float formatting with 2 decimal places *)
      item.tax    (* Use %.2f for float formatting with 2 decimal places *)
  ) items

  
(** Print order summaries *)
let print_order_summaries summaries =
  Printf.printf "\n===== ORDER SUMMARIES =====\n";
  Printf.printf "%-8s %-15s %-15s\n" 
    "ORDER_ID" "TOTAL_AMOUNT" "TOTAL_TAXES";
  Printf.printf "%s\n" (String.make 45 '-');
  
  List.iter (fun summary ->
    Printf.printf "%-8d %-15.2f %-15.2f\n" 
      summary.order_id
      summary.total_amount
      summary.total_taxes
  ) summaries



(** Write a list of order summaries to a CSV file. *)
let write_summaries_csv (filename : string) (summaries : order_summary list) : unit =
  let headers = ["order_id"; "total_amount"; "total_taxes"] in
  let data =
    List.map
      (fun (summary : order_summary) ->
         [
           string_of_int summary.order_id;
           Printf.sprintf "%.2f" summary.total_amount; (* Format float to 2 decimal places *)
           Printf.sprintf "%.2f" summary.total_taxes;  (* Format float to 2 decimal places *)
         ]
      )
      summaries
  in
  (* Use the existing write_csv function from Csv_processor *)
  write_csv filename headers data
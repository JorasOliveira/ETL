(** Pure functions for transforming CSV data to records *)

open Types (* Make types available *)

(** Convert a CSV row (list of strings) to an order record.
    @param row List of strings representing a CSV row
    @return Order record
    @raise Failure if row format or data is invalid
*)
val csv_to_order : string list -> order

(** Convert a CSV row (list of strings) to an order_item record.
    @param row List of strings representing a CSV row
    @return Order_item record
    @raise Failure if row format or data is invalid
*)
val csv_to_order_item : string list -> order_item

(** Convert a list of CSV rows to a list of order records.
    Assumes the first row is a header and skips it.
    @param rows List of string lists representing CSV rows (including header)
    @return List of order records
    @raise Failure if any data row format is invalid
*)
val csv_rows_to_orders : string list list -> order list

(** Convert a list of CSV rows to a list of order_item records.
    Assumes the first row is a header and skips it.
    @param rows List of string lists representing CSV rows (including header)
    @return List of order_item records
    @raise Failure if any data row format is invalid
*)
val csv_rows_to_order_items : string list list -> order_item list
(* In lib/printer.mli *)

open Types

(** Print a list of orders to the console in a formatted table. *)
val print_orders : order list -> unit

(** Print a list of order items with all details. *)
val print_order_items : order_item list -> unit (* Renamed from print_basic_items *)

(** Print a list of order summaries to the console in a formatted table. *)
val print_order_summaries : order_summary list -> unit

(** Write a list of order summaries to a CSV file.
    @param filename The path to the output CSV file.
    @param summaries The list of order_summary records to write.
*)
val write_summaries_csv : string -> order_summary list -> unit
(* lib/summarizer.mli *)

open Types

(** Calculate order summaries from a list of order items.
    Groups items by order_id and calculates total amount and taxes.
    @param items The list of all order_item records.
    @return A list of order_summary records, one for each unique order_id found in items.
*)
val calculate_summaries : order_item list -> order_summary list

(** Filter a list of order summaries based on optional criteria from the original orders.
    @param summaries The list of order_summary records to filter.
    @param orders The original list of order records (used for status/origin lookup).
    @param filter_status An optional status string. If Some(s), only keep summaries whose original order status matches s.
    @param filter_origin An optional origin string. If Some(o), only keep summaries whose original order origin matches o.
    @return The filtered list of order_summary records.
*)
val filter_summaries :
  order_summary list ->
  order list ->
  filter_status:string option ->
  filter_origin:string option ->
  order_summary list
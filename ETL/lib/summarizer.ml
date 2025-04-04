(* lib/summarizer.ml *)

open Types

(* Helper module for mapping order IDs (integers) *)
module IntMap = Map.Make(Int)

(** Calculate order summaries from a list of order items. *)
let calculate_summaries (items : order_item list) : order_summary list =
  (* Fold over items to build a map: order_id -> (current_total_amount, current_total_tax) *)
  let summary_map =
    List.fold_left
      (fun map (item : Types.order_item) ->
        let item_amount = float_of_int item.quantity *. item.price in
        (* Tax is percentage applied to item_amount *)
        let item_tax = item_amount *. item.tax in
        let order_id = item.order_id in

        (* Find existing accumulated values for this order_id *)
        let current_amount, current_tax =
          match IntMap.find_opt order_id map with
          | Some (acc_amount, acc_tax) -> (acc_amount, acc_tax)
          | None -> (0.0, 0.0) (* Start with zero if first item for this order *)
        in

        (* Add updated values back to the map *)
        IntMap.add order_id (current_amount +. item_amount, current_tax +. item_tax) map
      )
      IntMap.empty (* Start with an empty map *)
      items
  in

  (* Convert the map into a list of order_summary records *)
  IntMap.bindings summary_map (* Get list of (key, value) pairs *)
  |> List.map (fun (id, (total, tax)) ->
       { order_id = id; total_amount = total; total_taxes = tax }
     )

(** Filter a list of order summaries based on optional criteria *)
let filter_summaries
    (summaries : order_summary list)
    (orders : order list)
    ~(filter_status : string option) (* Use labeled arguments for clarity *)
    ~(filter_origin : string option) : order_summary list =

  (* Create a map for quick lookup of order details by order_id *)
  let order_details_map =
    List.fold_left
      (fun map (order : order) -> IntMap.add order.id order map)
      IntMap.empty
      orders
  in

  List.filter
    (fun (summary : order_summary) ->
      match IntMap.find_opt summary.order_id order_details_map with
      | None -> false (* Exclude summary if original order is missing *)
      | Some order ->
          (* Check status filter *)
          let status_match =
            match filter_status with
            | None -> true (* No filter applied, always matches *)
            | Some fs -> String.equal order.status fs
          in
          (* Check origin filter *)
          let origin_match =
            match filter_origin with
            | None -> true (* No filter applied, always matches *)
            | Some fo -> String.equal order.origin fo
          in
          (* Keep summary only if both filters match (or are not applied) *)
          status_match && origin_match
    )
    summaries
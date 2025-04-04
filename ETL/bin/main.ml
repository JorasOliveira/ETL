open ETL.Csv_processor
open ETL.Parser
(* open ETL.Types *)
open ETL.Printer
open ETL.Summarizer (* Open the new module *)

(** Main program entry point *)
let () =
  (* --- Configuration --- *)
  let orders_path = "/home/jj/insper/10_semestre/funcional/ETL/ETL/test/data/order.csv" in
  let items_path = "/home/jj/insper/10_semestre/funcional/ETL/ETL/test/data/order_item.csv" in
  let output_summary_path = "/home/jj/insper/10_semestre/funcional/ETL/ETL/test/data/order_summary_output.csv" in (* Define output file *)

  (* Filtering Parameters (Set to None to disable filter) *)
  let filter_status = Some "Complete" (* Example: Only 'Complete' orders *)
  (* let filter_status = None (* Example: No status filter *) *)
  in  
  let filter_origin = None (* Example: No origin filter *)
  (* let filter_origin = Some "P" (* Example: Only 'P' origin *) *)
  in

  (* --- ETL Process --- *)
  (* Printf.printf "ETL Process Starting\n";
  Printf.printf "-------------------\n"; *)

  (* Read CSV files *)
  (* Printf.printf "Reading orders from %s...\n" orders_path; *)
  let orders_csv = read_csv orders_path in
  let orders_csv_filtered = filter_empty_rows orders_csv in
  (* Printf.printf "Found %d order rows (after filtering empty)\n" (count_rows orders_csv_filtered); *)

  (* Printf.printf "Reading order items from %s...\n" items_path; *)
  let order_items_csv = read_csv items_path in
  let order_items_csv_filtered = filter_empty_rows order_items_csv in
  (* Printf.printf "Found %d order item rows (after filtering empty)\n" (count_rows order_items_csv_filtered); *)

  (* Convert CSV to records *)
  let orders = csv_rows_to_orders orders_csv_filtered in
  let items = csv_rows_to_order_items order_items_csv_filtered in
  (* Printf.printf "Processed %d orders and %d items\n"
    (List.length orders) (List.length items); *)

  (* Print raw data (optional verification) *)
  (* print_orders orders; *)
  (* print_order_items items; *)

  (* --- Calculation and Filtering --- *)
  (* Printf.printf "Calculating order summaries...\n"; *)
  let all_summaries = calculate_summaries items in
  (* Printf.printf "Calculated %d summaries initially.\n" (List.length all_summaries); *)

  (* Printf.printf "Filtering summaries (Status: %s, Origin: %s)...\n"
  (match filter_status with Some s -> s | None -> "None")
  (match filter_origin with Some o -> o | None -> "None"); *)
  let filtered_summaries = filter_summaries all_summaries orders ~filter_status ~filter_origin in
  (* Printf.printf "Found %d summaries after filtering.\n" (List.length filtered_summaries); *)

  (* --- Output --- *)
  (* Print filtered summaries to console (optional) *)
  (* print_order_summaries filtered_summaries; *)

  (* Write filtered summaries to CSV *)
  (* Printf.printf "Writing filtered summaries to %s...\n" output_summary_path; *)
  write_summaries_csv output_summary_path filtered_summaries;

  (* Printf.printf "\nETL processing complete.\nOutput written to %s\n" output_summary_path *)
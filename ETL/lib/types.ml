(** Type definitions for the ETL process *)

(** Record type for orders from the CSV *)
type order = {
  id: int;
  client_id: int;
  order_date: string;
  status: string;
  origin: string;
}

(** Record type for order items from the CSV *)
type order_item = {
  order_id: int;
  product_id: int;
  quantity: int;
  price: float;
  tax: float;
}

(** Record type for the output summary *)
type order_summary = {
  order_id: int;
  total_amount: float;
  total_taxes: float;
}
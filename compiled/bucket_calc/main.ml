let () =
  let start = 1.0 in
  let end_val = 100000.0 in
  let num_bins = 20 in
  let log_base = (end_val /. start) ** (1.0 /. float_of_int num_bins) in
  let bin_edges_int = List.init (num_bins + 1) (fun i ->
    int_of_float (Float.round (start *. log_base ** float_of_int i))
  ) in
  print_string (String.concat ", " (List.map string_of_int bin_edges_int));
  print_newline ()

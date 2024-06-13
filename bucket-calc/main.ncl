# Constants
let start = 1 in
let end = 100000 in
let num_bins = 20 in

# Calculating the base of the logarithm
let log_base = std.number.pow (end / start) (1 / num_bins) in

# Calculating the bin edges
let bin_edges =
  std.array.range 0 (num_bins + 1)
  |> std.array.map (fun i => start * (std.number.pow log_base i))
in
let bin_edges_int =
  bin_edges
  |> std.array.map (fun x => std.number.floor (x + 0.5))
in
bin_edges_int

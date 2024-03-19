#{
// Constants
let start = 1
let end = 100000
let num_bins = 20

// Calculating the base of the logarithm
let log_base = calc.pow((end / start), (1 / num_bins))

// Calculating the bin edges
let bin_edges = for i in range(num_bins + 1) {
  (start * calc.pow(log_base, i),)
}

// Uncomment below line to get bin_edges before rounding
// [bin_edges before rounding: #bin_edges]

// Rounding the bin edges to the nearest integer
let bin_edges_int = bin_edges.map(edge => int(calc.round(edge)))

// Uncomment below line to include integer bin edges
// [bin_edges_int: #bin_edges_int]

bin_edges_int.map(str).join(",")

} <main>

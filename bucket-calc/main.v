import math

start := 1.0
end_val := 100000.0
num_bins := 20

log_base := math.pow(end_val / start, 1.0 / f64(num_bins))

mut bin_edges_int := []int{}
for i in 0 .. num_bins + 1 {
	bin_edges_int << int(math.round(start * math.pow(log_base, f64(i))))
}

println(bin_edges_int)

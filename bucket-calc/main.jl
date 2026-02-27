start = 1
stop = 100000
num_bins = 20

log_base = (stop / start) ^ (1 / num_bins)

bin_edges = [start * log_base^i for i in 0:num_bins]
bin_edges_int = round.(Int, bin_edges)

println(bin_edges_int)

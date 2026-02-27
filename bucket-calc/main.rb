start = 1
end_val = 100000
num_bins = 20

log_base = (end_val.to_f / start) ** (1.0 / num_bins)

bin_edges = (0..num_bins).map { |i| start * log_base ** i }
bin_edges_int = bin_edges.map { |edge| edge.round }

puts bin_edges_int.inspect

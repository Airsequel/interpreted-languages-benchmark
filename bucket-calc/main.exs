start = 1
stop = 100_000
num_bins = 20

log_base = :math.pow(stop / start, 1 / num_bins)

bin_edges_int =
  for i <- 0..num_bins do
    round(start * :math.pow(log_base, i))
  end

IO.inspect(bin_edges_int)

local start = 1
local _end = 100000
local num_bins = 20

local log_base = (_end / start) ^ (1 / num_bins)

local bin_edges_int = {}
for i = 0, num_bins do
    table.insert(bin_edges_int, math.floor(start * log_base ^ i + 0.5))
end

print(table.concat(bin_edges_int, ", "))

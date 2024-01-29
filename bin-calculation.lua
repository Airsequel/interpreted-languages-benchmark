-- Constants
local start = 1
local _end = 100000  -- '_end' instead of 'end' because 'end' is a reserved keyword in Lua
local num_bins = 20

-- Calculating the base of the logarithm
local log_base = (_end / start) ^ (1 / num_bins)

-- Calculating the bin edges
local bin_edges = {}
for i = 0, num_bins do
    table.insert(bin_edges, start * log_base^i)
end

-- Uncomment below line to print bin_edges before rounding
-- print(table.concat(bin_edges, ", "), "========================================")

-- Rounding the bin edges to the nearest integer
local bin_edges_int = {}
for _, edge in ipairs(bin_edges) do
    table.insert(bin_edges_int, math.floor(edge + 0.5))
end

-- Print rounded bin edges
print(table.concat(bin_edges_int, ", "))

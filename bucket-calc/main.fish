set start 1
set end_val 100000
set num_bins 20

set log_base (math "pow($end_val / $start, 1 / $num_bins)")

set edges
for i in (seq 0 $num_bins)
    set -a edges (math "round(pow($log_base, $i))")
end

echo (string join ", " $edges)

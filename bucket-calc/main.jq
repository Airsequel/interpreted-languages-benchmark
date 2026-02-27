1 as $start |
100000 as $end |
20 as $num_bins |
pow($end / $start; 1 / $num_bins) as $log_base |
[range($num_bins + 1) | $start * pow($log_base; .) | round]

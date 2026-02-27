<?php

$start = 1;
$end = 100000;
$num_bins = 20;

$log_base = pow($end / $start, 1 / $num_bins);

$bin_edges_int = [];
for ($i = 0; $i <= $num_bins; $i++) {
    $bin_edges_int[] = (int) round($start * pow($log_base, $i));
}

echo implode(", ", $bin_edges_int) . "\n";

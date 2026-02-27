set start 1
set end 100000
set num_bins 20

set log_base [expr {pow(double($end) / $start, 1.0 / $num_bins)}]

set bin_edges_int {}
for {set i 0} {$i <= $num_bins} {incr i} {
    lappend bin_edges_int [expr {round($start * pow($log_base, $i))}]
}

puts $bin_edges_int

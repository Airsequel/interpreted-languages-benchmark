let start = 1
let end_val = 100000
let num_bins = 20
let log_base = ($end_val / $start) ** (1 / $num_bins)

0..$num_bins | each {|i| ($start * ($log_base ** $i)) | math round | into int } | str join ", " | print

my $start = 1;
my $end = 100000;
my $num_bins = 20;

my $log_base = ($end / $start) ** (1 / $num_bins);

my @bin_edges_int;
for my $i (0 .. $num_bins) {
    push @bin_edges_int, int($start * $log_base ** $i + 0.5);
}

print join(", ", @bin_edges_int), "\n";

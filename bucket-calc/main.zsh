start=1.0
end_val=100000.0
num_bins=20

log_base=$(( end_val ** (1.0 / num_bins) ))

for (( i = 0; i <= num_bins; i++ )); do
    (( i > 0 )) && printf ", "
    printf "%.0f" $(( start * log_base ** i ))
done
echo

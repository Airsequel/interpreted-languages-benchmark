awk 'BEGIN {
    start = 1; end_val = 100000; n = 20
    base = (end_val / start) ^ (1 / n)
    for (i = 0; i <= n; i++) {
        edge = int(start * base ^ i + 0.5)
        printf "%s%d", (i > 0 ? ", " : ""), edge
    }
    print ""
}'

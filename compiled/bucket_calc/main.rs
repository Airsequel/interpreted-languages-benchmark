fn main() {
    let start: f64 = 1.0;
    let end: f64 = 100000.0;
    let num_bins: usize = 20;

    let log_base = (end / start).powf(1.0 / num_bins as f64);

    let bin_edges_int: Vec<i64> = (0..=num_bins)
        .map(|i| (start * log_base.powi(i as i32)).round() as i64)
        .collect();

    println!("{:?}", bin_edges_int);
}

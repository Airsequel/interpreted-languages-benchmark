let
  # # Calculate the power of a base to a floating-point exponent.
  # pow = base: exponent:
  #   if exponent == 0.0
  #   then 1.0
  #   else if exponent > 0.0
  #     then base * (intPow base (builtins.floor exponent))
  #     else 1.0 / (intPow base (builtins.floor (-exponent)));

  # Modulo function for floating-point numbers
  mod = n: d:
    n - (builtins.floor (n / d)) * d;

  # Calculate the power of a base to an integer exponent.
  intPow = base: exponent:
    if exponent == 0
    then 1
    else
      if exponent > 0
      then base * (intPow base (exponent - 1))
      else 1 / (intPow base (-exponent));

  # Root calculation (using approximation)
  root = x: n: # (Approximates the n-th root of x)
    let
      approx = x;
      rec_ = approx: approx * ((n - 1) + x / (intPow approx (n - 1))) / n;
    in builtins.trace rec_ rec_; # Adjust iterations as needed

  # Our revised pow function
  pow = x: y:
    if mod y 1 == 0 then  # Integer exponent
      intPow x y
    else
      let
        p = builtins.floor y;
        q = y - p;
      in intPow (root x ((1 / q))) p;

  # round = x:
  #   let
  #     intPart = builtins.floor x; # Get the integer part
  #     fracPart = x - intPart; # Get the fractional part
  #   in
  #     if fracPart < 0.5 then intPart else intPart + 1;

  # # Constants
  # start = 1.0;
  # end = 100000.0;
  # numBins = 20.0;

  # # Calculating the base of the logarithm
  # logBase = pow (end / start) (1.0 / numBins);

  # # Recursive function to calculate bin edges
  # calcBinEdges = n: acc: if n > numBins
  #   then acc
  #   else calcBinEdges (n + 1) (acc ++ [(start*(pow logBase n))]);

  # # Initializing calculation with n = 0 and an empty accumulator
  # binEdges = calcBinEdges 0 [];

  # # Rounding the bin edges to the nearest integer
  # binEdgesInt = map (edge: round edge) binEdges;

in
  pow 5 0.2

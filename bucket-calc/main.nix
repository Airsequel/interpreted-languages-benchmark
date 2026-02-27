let
  intPow = base: exp:
    if exp == 0 then 1.0
    else if exp == 1 then base
    else base * (intPow base (exp - 1));

  nthRoot = x: n:
    let
      iterate = guess: remaining:
        if remaining == 0 then guess
        else
          iterate
            (((n - 1) * guess + x / (intPow guess (n - 1))) / n)
            (remaining - 1);
    in iterate 2.0 100;

  round = x:
    let f = builtins.floor x;
    in if x - f >= 0.5 then f + 1 else f;

  logBase = nthRoot 100000.0 20;

  binEdgesInt = builtins.genList (i: round (intPow logBase i)) 21;
in
  binEdgesInt

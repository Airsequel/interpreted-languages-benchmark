import std/math
import std/strutils

let
  start = 1.0
  endVal = 100000.0
  numBins = 20

let logBase = pow(endVal / start, 1.0 / numBins.float)

var binEdgesInt: seq[int]
for i in 0 .. numBins:
  binEdgesInt.add(int(round(start * pow(logBase, i.float))))

echo binEdgesInt.join(", ")

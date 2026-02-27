import 'dart:math';

void main() {
  var start = 1;
  var endVal = 100000;
  var numBins = 20;

  var logBase = pow(endVal.toDouble() / start, 1.0 / numBins).toDouble();

  var binEdgesInt = List.generate(
      numBins + 1, (i) => (start * pow(logBase, i)).round());

  print(binEdgesInt);
}

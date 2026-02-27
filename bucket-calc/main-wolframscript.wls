start = 1;
endVal = 100000;
numBins = 20;

logBase = N[Power[endVal/start, 1/numBins]];
binEdgesInt = Round[Table[start * Power[logBase, i], {i, 0, numBins}]];

Print[binEdgesInt]

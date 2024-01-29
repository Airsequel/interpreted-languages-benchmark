// Constants
const start = 1
const end = 100000
const numBins = 20

// Calculating the base of the logarithm
const logBase = Math.pow(end / start, 1 / numBins)

// Calculating the bin edges
const binEdges = []
for (let i = 0; i <= numBins; i++) {
    binEdges.push(start * Math.pow(logBase, i))
}

// Rounding the bin edges to the nearest integer
const binEdgesInt = binEdges.map(edge => Math.round(edge))

// Print bin edges
console.log(binEdgesInt)

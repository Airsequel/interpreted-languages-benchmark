// Constants
const start: number = 1
const end: number = 100000
const numBins: number = 20

// Calculating the base of the logarithm
const logBase: number = Math.pow(end / start, 1 / numBins)

// Calculating the bin edges
const binEdges: number[] = []
for (let i = 0; i <= numBins; i++) {
    binEdges.push(start * Math.pow(logBase, i))
}

// Rounding the bin edges to the nearest integer
const binEdgesInt: number[] = binEdges.map(edge => Math.round(edge))

// Print bin edges
console.log(binEdgesInt)

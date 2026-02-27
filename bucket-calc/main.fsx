let start = 1.0
let endVal = 100000.0
let numBins = 20

let logBase = (endVal / start) ** (1.0 / float numBins)

let binEdgesInt =
    [| for i in 0 .. numBins -> int (System.Math.Round(start * logBase ** float i)) |]

printfn "%A" binEdgesInt

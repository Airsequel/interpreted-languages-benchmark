def start = 1
def end = 100000
def numBins = 20

def logBase = Math.pow(end / start, 1.0 / numBins)

def binEdgesInt = (0..numBins).collect { i -> Math.round(start * Math.pow(logBase, i)) }

println binEdgesInt

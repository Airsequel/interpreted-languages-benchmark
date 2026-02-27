@main def run(): Unit =
  val start = 1.0
  val endVal = 100000.0
  val numBins = 20

  val logBase = math.pow(endVal / start, 1.0 / numBins)

  val binEdgesInt = (0 to numBins).map(i =>
    math.round(start * math.pow(logBase, i))
  )

  println(binEdgesInt.mkString(", "))

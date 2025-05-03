#!/usr/bin/env roc

app "hello-world"
  packages {
    pf: "https://github.com/roc-lang/basic-cli/releases/download/0.10.0/vNe6s9hWzoTZtFmNkvEICPErI9ptji_ySjicO6CkucY.tar.br"
}
  imports [pf.Stdout, pf.Task.{ Task }, pf.Utc]
  provides [main] to pf


main : Task {} _
main =
  now = Utc.now!
  # TODO: Use https://github.com/imclerran/roc-isodate to format the date
  nowStr = now |> Utc.toMillisSinceEpoch |> Num.toStr
  Stdout.line! nowStr

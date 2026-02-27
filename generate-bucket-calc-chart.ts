#!/usr/bin/env bun

import fs from "fs"
import path from "path"
import vega from "./shebang-scripts/node_modules/vega"
import vl from "./shebang-scripts/node_modules/vega-lite"

// Load data from the JSON file
const data = JSON.parse(
  fs.readFileSync(
    path.join(import.meta.dirname, "bucket-calc/result.json"),
    "utf8",
  ),
)

// Extract data from the JSON
const results: { command: string; mean_time: number }[] = data.results.map(
  (result) => {
    let command = result.command
      // Special cases with flags, subcommands, or disambiguation
      .replace('sqlite3 :memory: -init bucket-calc/main.sql ""', "sqlite")
      .replace(
        'typst query --field=text --one bucket-calc/main.typ "<main>"',
        "typst",
      )
      .replace("nix eval --file bucket-calc/main.nix", "nix")
      .replace("java --source 11 bucket-calc/main.java", "java")
      .replace("nim r --hints:off bucket-calc/main.nim", "nim")
      .replace("nickel export bucket-calc/main.ncl", "nickel")
      .replace(
        "wolframscript -file bucket-calc/main-wolframscript.wls",
        "wolframscript",
      )
      .replace("woxi run bucket-calc/main-woxi.wls", "woxi")
      .replace("dotnet fsi bucket-calc/main.fsx", "fsharp")
      .replace("guile -s bucket-calc/main.scm", "guile")
      .replace("jq -n -f bucket-calc/main.jq", "jq")
      .replace("deno run bucket-calc/main.ts", "deno-ts")
      .replace("deno run bucket-calc/main.js", "deno-js")
      .replace("bun run bucket-calc/main.ts", "bun-ts")
      .replace("bun run bucket-calc/main.js", "bun-js")
      .replace("dart run bucket-calc/main.dart", "dart")
      .replace("v run bucket-calc/main.v", "v")
      .replace("uiua run bucket-calc/main.ua", "uiua")
      .replace("scala-cli run bucket-calc/main.scala", "scala")
      // Generic: "interpreter bucket-calc/main.ext" → "interpreter"
      .replace(/\s*bucket-calc\/\S+/g, "")
      .trim()
    return {
      command: command,
      mean_time: result.mean,
    }
  },
)

console.log({ results })

// Convert results to a DataFrame-like structure
const df = results.map((result, index) => ({
  ...result,
  relative_speed: 0, // Placeholder for now
}))

// Find the fastest entry (smallest mean_time)
const fastestEntry = df.reduce((min, entry) => {
  return entry.mean_time < min.mean_time ? entry : min
}, df[0])

const fastestCommand = fastestEntry.command
const fastestTime: number = fastestEntry.mean_time

// Calculate times faster relative to the fastest entry
df.forEach((entry) => {
  entry.relative_speed = fastestTime / entry.mean_time
})

// Sort the DataFrame by relative_speed
df.sort((a, b) => b.relative_speed - a.relative_speed)

console.log(df)

// Define the Vega-Lite chart specification
const spec = {
  $schema: "https://vega.github.io/schema/vega-lite/v5.json",
  title: `Bucket Calc - Relative Execution Speed (Higher is Better)`,
  mark: "bar",
  width: 800,
  height: 400,
  encoding: {
    x: {
      field: "command",
      type: "nominal",
      sort: "-y",
      title: "Command",
      axis: {
        labelAngle: -45,
      },
    },
    y: {
      field: "relative_speed",
      type: "quantitative",
      title: `Relative Speed in Comparison to ${fastestCommand}`,
    },
    tooltip: [{ field: "command" }, { field: "relative_speed" }],
  },
  data: {
    values: df,
  },
}

// Create a Vega view for rendering
const runtime = vl.compile(spec).spec
const view = new vega.View(vega.parse(runtime), { renderer: "none" })

// Export to SVG
view.toSVG().then((svg) => {
  fs.writeFileSync(
    path.join(import.meta.dirname, "bucket-calc/chart.svg"),
    svg,
  )
  console.log("Bucket calc chart generated successfully!")
})

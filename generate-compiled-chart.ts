#!/usr/bin/env bun

import fs from "fs"
import path from "path"
import vega from "./shebang-scripts/node_modules/vega"
import vl from "./shebang-scripts/node_modules/vega-lite"

// Load data from the JSON file
const data = JSON.parse(
  fs.readFileSync(
    path.join(import.meta.dirname, "compiled/hello_world/result.json"),
    "utf8",
  ),
)

// Extract data from the JSON
const results: { command: string; mean_time: number }[] = data.results.map(
  (result) => {
    let command = result.command
        .replace("./output/hello_world/main-", "")
        .replace("./output/hello_world/main", "")
        .replace("java -cp output/hello_world/main-", "")
        .replace(".jar MainKt", "")
        .replace(".jar Main", "")
        .replace("julia compiled/hello_world/main.jl", "julia")
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
  title: `Compiled Languages - Relative Execution Speed (Higher is Better)`,
  mark: "bar",
  width: 800,
  height: 400,
  encoding: {
    x: {
      field: "command",
      type: "nominal",
      sort: "-y",
      title: "Language",
      axis: {
        labelAngle: -45,
      }
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
    path.join(import.meta.dirname, "compiled/hello_world/compiled-chart.svg"),
    svg,
  )
  console.log("Compiled languages chart generated successfully!")
})

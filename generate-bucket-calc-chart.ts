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

function parseResult(command: string): { name: string; type: string } {
  // Compiled binaries
  if (command.startsWith("./output/bucket_calc/main-")) {
    return {
      name: command.replace("./output/bucket_calc/main-", ""),
      type: "compiled",
    }
  }
  if (command.startsWith("java -cp output/bucket_calc/")) {
    return { name: "java", type: "compiled" }
  }

  // Interpreted - special cases with flags, subcommands, or disambiguation
  const specialCases: Record<string, string> = {
    'sqlite3 :memory: -init bucket-calc/main.sql ""': "sqlite",
    'typst query --field=text --one bucket-calc/main.typ "<main>"': "typst",
    "nix eval --file bucket-calc/main.nix": "nix",
    "java --source 11 compiled/bucket_calc/Main.java": "java-source",
    "nim r --hints:off compiled/bucket_calc/main.nim": "nim-r",
    "nickel export bucket-calc/main.ncl": "nickel",
    "woxi run bucket-calc/main-woxi.wls": "woxi",
    "dotnet fsi bucket-calc/main.fsx": "fsharp",
    "guile -s bucket-calc/main.scm": "guile",
    "jq -n -f bucket-calc/main.jq": "jq",
    "deno run bucket-calc/main.ts": "deno-ts",
    "deno run bucket-calc/main.js": "deno-js",
    "bun run bucket-calc/main.ts": "bun-ts",
    "bun run bucket-calc/main.js": "bun-js",
    "dart run bucket-calc/main.dart": "dart",
    "v run compiled/bucket_calc/main.v": "v-run",
    "uiua run bucket-calc/main.ua": "uiua",
    "scala-cli run bucket-calc/main.scala": "scala",
    "runhaskell compiled/bucket_calc/Main.hs": "runhaskell",
    "ocaml compiled/bucket_calc/main.ml": "ocaml-script",
    "rust-script compiled/bucket_calc/main.rs": "rust-script",
  }
  if (specialCases[command]) {
    return { name: specialCases[command], type: "interpreted" }
  }

  // Interpreted - generic: "interpreter bucket-calc/main.ext"
  const genericMatch = command.match(/\s*bucket-calc\/\S+/g)
  if (genericMatch) {
    return {
      name: command.replace(/\s*bucket-calc\/\S+/g, "").trim(),
      type: "interpreted",
    }
  }

  // Interpreted - generic: "interpreter compiled/bucket_calc/main.ext"
  const compiledMatch = command.match(/\s*compiled\/bucket_calc\/\S+/g)
  if (compiledMatch) {
    return {
      name: command.replace(/\s*compiled\/bucket_calc\/\S+/g, "").trim(),
      type: "interpreted",
    }
  }

  // Fallback
  return { name: command.split(" ")[0], type: "interpreted" }
}

// Extract data from the JSON
const df: {
  command: string
  type: string
  mean_time: number
  relative_speed: number
}[] = data.results.map((result) => {
  const { name, type } = parseResult(result.command)
  return {
    command: name,
    type,
    mean_time: result.mean,
    relative_speed: 0,
  }
})

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
    color: {
      field: "type",
      type: "nominal",
      title: "Type",
      scale: {
        domain: ["compiled", "interpreted"],
        range: ["steelblue", "coral"],
      },
    },
    tooltip: [
      { field: "command" },
      { field: "type" },
      { field: "relative_speed" },
    ],
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

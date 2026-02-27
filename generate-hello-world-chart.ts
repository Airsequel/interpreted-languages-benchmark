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

function parseResult(command: string): { name: string; type: string } {
  // Compiled binaries
  if (command.startsWith("./output/hello_world/mainmicro-")) {
    return { name: "microhs", type: "compiled" }
  }
  if (command.startsWith("./output/hello_world/main-")) {
    return {
      name: command.replace("./output/hello_world/main-", ""),
      type: "compiled",
    }
  }
  if (command.startsWith("java -cp")) {
    if (command.includes("kotlin")) return { name: "kotlin", type: "compiled" }
    return { name: "java", type: "compiled" }
  }

  // Interpreted - special cases with flags or non-shebang paths
  const specialCases: Record<string, string> = {
    'sqlite3 :memory: -init compiled/hello_world/main.sql ""': "sqlite",
    "dart run compiled/hello_world/main.dart": "dart",
    "dotnet fsi ./shebang-scripts/hello_world/fsharp.fsx": "fsharp",
    "guile -s ./shebang-scripts/hello_world/guile": "guile",
    "jq -n -f ./shebang-scripts/hello_world/jq": "jq",
    "java --source 11 ./shebang-scripts/hello_world/java": "java-source",
    "nim r --hints:off compiled/hello_world/main.nim": "nim-r",
    "runhaskell compiled/hello_world/Main.hs": "runhaskell",
    "mhs -r compiled/hello_world/MainMicro.hs": "mhs-r",
    "ocaml compiled/hello_world/main.ml": "ocaml-script",
    "v run compiled/hello_world/main.v": "v-run",
    "php compiled/hello_world/main.php": "php",
    "uiua run compiled/hello_world/main.ua": "uiua",
    "make -f ./shebang-scripts/hello_world/make": "make",
    "wolframscript -file ./shebang-scripts/hello_world/wolfram-language-wolframscript":
      "wolframscript",
    "woxi run ./shebang-scripts/hello_world/wolfram-language-woxi": "woxi",
    "bun run ./shebang-scripts/hello_world/javascript-bun": "javascript-bun",
  }
  if (specialCases[command]) {
    return { name: specialCases[command], type: "interpreted" }
  }

  // Interpreted - generic: "interpreter ./shebang-scripts/hello_world/name"
  const shebangMatch = command.match(
    /\s*\.\/shebang-scripts\/hello_world\/(.+)$/,
  )
  if (shebangMatch) {
    return { name: shebangMatch[1], type: "interpreted" }
  }

  // Fallback
  return { name: command.split(" ")[0], type: "interpreted" }
}

// Extract data from the JSON
const df: { command: string; type: string; mean_time: number; relative_speed: number }[] =
  data.results.map((result) => {
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
  title: "Hello World - Relative Execution Speed (Higher is Better)",
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
    path.join(
      import.meta.dirname,
      "compiled/hello_world/hello-world-chart.svg",
    ),
    svg,
  )
  console.log("Hello world chart generated successfully!")
})

# Interpreted Languages Benchmark

Benchmark for interpreted languages.


## Languages

- JavaScript via
  - [Node.js]
  - [Deno]
  - [Bun]
- TypeScript via
  - [Deno]
  - [Bun]
- [Python]
- [Lua]
- [Nickel]
- [Typst]

[Bun]: https://bun.sh/
[Deno]: https://deno.com/
[Lua]: https://www.lua.org/
[Nickel]: https://nickel-lang.org/
[Node.js]: https://nodejs.org/
[Python]: https://www.python.org/
[Typst]: https://typst.app/docs/


### Workarounds

- [Typst] \
    Can only output a JSON string.
    Use `… | jq -r` to remove the quotes.


## Result

### MacBook Pro 14"

```yaml
Year: 2021
Chip: Apple M1 Pro
Memory: 16 GB
macOS: 13.6.2
```

On 2024-01-29:

```txt
nickel-lang-cli nickel 1.3.0 (rev Homebre)
Python 3.11.6
Lua 5.4.6  Copyright (C) 1994-2023 Lua.org, PUC-Rio
deno 1.39.1 (release, aarch64-apple-darwin)
v8 12.0.267.8
typescript 5.3.3
bun --version
1.0.20
node --version
v20.7.0
hyperfine 1.18.0

===== Running Benchmark =====

Summary
  lua bin-calculation.lua ran
    4.71 ± 0.39 times faster than nickel export bin-calculation.ncl
    5.89 ± 0.50 times faster than bun run bin-calculation.js
    6.00 ± 0.51 times faster than bun run bin-calculation.ts
   11.09 ± 1.11 times faster than python3 bin-calculation.py
   11.82 ± 0.92 times faster than deno run bin-calculation.ts
   11.86 ± 1.07 times faster than deno run bin-calculation.js
   17.90 ± 1.33 times faster than node bin-calculation.js
```


### Mac mini

```yaml
Year: 2018
Processor: 3.2 GHz 6-Core Intel Core i7
Memory: 32 GB 2667 MHz DDR4
macOS: 13.6.3
```

On 2024-01-29:

```txt
nickel-lang-cli nickel 1.4.0 (rev Homebre)
Python 3.11.7
Lua 5.4.6  Copyright (C) 1994-2023 Lua.org, PUC-Rio
deno 1.39.4 (release, x86_64-apple-darwin)
v8 12.0.267.8
typescript 5.3.3
bun --version
1.0.23
node --version
v20.10.0
hyperfine 1.18.0

===== Running Benchmark =====

Summary
  lua bin-calculation.lua ran
    4.09 ± 0.52 times faster than nickel export bin-calculation.ncl
    4.70 ± 0.54 times faster than bun run bin-calculation.ts
    4.93 ± 0.75 times faster than bun run bin-calculation.js
    8.36 ± 1.00 times faster than python3 bin-calculation.py
    8.83 ± 1.21 times faster than deno run bin-calculation.js
    8.85 ± 1.05 times faster than deno run bin-calculation.ts
   11.39 ± 1.33 times faster than node bin-calculation.js
```

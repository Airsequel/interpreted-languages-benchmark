# Interpreted Languages Benchmark

Benchmark for interpreted languages.

![Barchart for relative execution speed](shebang-scripts/today/chart.svg)

The values for Rust, V, Swift, D and Haskell are not really representative
as they are compiled on the first run
and Haskell unfortunately does not even cache the compiled binary.


## Languages

- [Bash]
- [Bun]
- [D]
- [Dart]
- [Dash]
- [Elixir]
- [Elvish]
- [F#]
- [Fish]
- [Guile]
- [Haskell]
- [Java]
- JavaScript via
  - [Node.js]
  - [Deno]
  - [Bun]
- [Julia]
- [Ksh]
- [Lua]
- [Lua]
- [Nickel]
- [Nix Language]
- [Nushell]
- [OCaml]
- [Osh]
- [Perl]
- [PHP]
- TypeScript via
  - [Deno]
  - [Bun]
- [Python]
- [Python]
- [R]
- [Racket]
- [Roc.roc]
- [Ruby]
- [Scala]
- [Swift]
- [Typst]
- [V]

[Bash]: https://www.gnu.org/software/bash/
[Bun]: https://bun.sh/
[D]: https://dlang.org
[Dart]: https://dart.dev/
[Dash]: https://wiki.archlinux.org/title/Dash
[Deno]: https://deno.com/
[Elixir]: https://elixir-lang.org/
[Elvish]: https://elv.sh/
[F#]: https://fsharp.org/
[Fish]: https://fishshell.com/
[Guile]: https://www.gnu.org/software/guile/
[Haskell]: https://www.haskell.org/
[Java]: https://www.java.com/
[Julia]: https://julialang.org/
[Ksh]: https://www.kornshell.com/
[Lua]: https://www.lua.org/
[Nickel]: https://nickel-lang.org/
[Nix Language]: https://nixos.org/manual/nix/stable/language/
[Node.js]: https://nodejs.org/
[Nushell]: https://www.nushell.sh/
[OCaml]: https://ocaml.org/
[Osh]: https://www.oilshell.org/
[Perl]: https://www.perl.org/
[PHP]: https://www.php.net/
[Python]: https://www.python.org/
[R]: https://www.r-project.org
[Racket]: https://racket-lang.org/
[Roc.roc]: https://roc-lang.org/
[Ruby]: https://www.ruby-lang.org/
[Scala]: https://www.scala-lang.org/
[Swift]: https://swift.org/
[Typst]: https://typst.app/docs/
[V]: https://vlang.io/


### Workarounds

- [Typst] \
    Can only output a JSON string.
    Use `… | jq -r` to remove the quotes.


## Result

Check out the
[workflow runs](https://github.com/Airsequel/interpreted-languages-benchmark/actions)
for the latest benchmark results.


## Related

- [ffi-overhead] - Comparing the C FFI overhead of various programming languages
- [gradbench] - Benchmarks for differentiable programming across languages and domains
- [jinyus/related_post_gen] - Data Processing benchmark
- [plb2] - A programming language benchmark
- [Programming-Language-Benchmarks][PLB]
- [script-bench-rs] - Rust embedded scripting languages benchmark

[ffi-overhead]: https://github.com/dyu/ffi-overhead
[gradbench]: https://github.com/gradbench/gradbench
[jinyus/related_post_gen]: https://github.com/jinyus/related_post_gen
[PLB]: https://github.com/hanabi1224/Programming-Language-Benchmarks
[plb2]: https://github.com/attractivechaos/plb2
[script-bench-rs]: https://github.com/khvzak/script-bench-rs

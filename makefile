.PHONY: help
help: makefile
	@tail -n +4 makefile | grep ".PHONY"


.PHONY: run-bucket-calc
run-bucket-calc:
	@hyperfine \
		--shell=none \
		--warmup 10 \
		--export-json bucket-calc/result.json \
		'python3 bucket-calc/main.py' \
		'ruby bucket-calc/main.rb' \
		'perl bucket-calc/main.pl' \
		'php bucket-calc/main.php' \
		'tclsh bucket-calc/main.tcl' \
		'node bucket-calc/main.js' \
		'deno run bucket-calc/main.ts' \
		'deno run bucket-calc/main.js' \
		'bun run bucket-calc/main.ts' \
		'bun run bucket-calc/main.js' \
		'lua bucket-calc/main.lua' \
		'luajit bucket-calc/main.lua' \
		'luau bucket-calc/main.luau' \
		'java --source 11 bucket-calc/main.java' \
		'groovy bucket-calc/main.groovy' \
		'dotnet fsi bucket-calc/main.fsx' \
		'dart run bucket-calc/main.dart' \
		'julia bucket-calc/main.jl' \
		'runhaskell bucket-calc/main.hs' \
		'ocaml bucket-calc/main.ml' \
		'nim r --hints:off bucket-calc/main.nim' \
		'rust-script bucket-calc/main.rs' \
		'v run bucket-calc/main.v' \
		'elixir bucket-calc/main.exs' \
		'escript bucket-calc/main.escript' \
		'janet bucket-calc/main.janet' \
		'guile -s bucket-calc/main.scm' \
		'jq -n -f bucket-calc/main.jq' \
		'uiua run bucket-calc/main.ua' \
		'sqlite3 :memory: -init bucket-calc/main.sql ""' \
		'nu bucket-calc/main.nu' \
		'nickel export bucket-calc/main.ncl' \
		'nix eval --file bucket-calc/main.nix' \
		'typst query --field=text --one bucket-calc/main.typ "<main>"' \
		'woxi run bucket-calc/main-woxi.wls' \
		'bash bucket-calc/main.bash' \
		'zsh bucket-calc/main.zsh' \
		'fish bucket-calc/main.fish' \
		'elvish bucket-calc/main.elv'


# Print all language and tool versions as one JSON object
.PHONY: print-versions
print-versions:
	@echo '{'
	@printf '"hyperfine": "%s",\n' "$$(hyperfine --version)"
	@printf '"bash": "%s",\n' "$$(bash --version | head -n1)"
	@printf '"d": "%s",\n' "$$(rdmd --version | head -n1)"
	@printf '"dart": "%s",\n' "$$(dart --version | tr -d '"')"
	@printf '"dash": "%s",\n' \
			"$$(brew info --json dash \
				| grep '"version":' \
				| awk -F '"' '{print $$4}' \
				)"
	@printf '"deno": "%s",\n' \
			"$$(deno --version \
				| awk '{printf "%s%s", (NR > 1 ? ", " : ""), $$0}' \
				| tr -d '"' \
				)"
	@printf '"bun": "%s",\n' "$$(bun --version)"
	@printf '"dotnet": "%s",\n' "$$(dotnet fsi --version)"
	@printf '"ksh": "%s",\n' "$$(echo "TODO")"
	@printf '"elixir": "%s",\n' "$$(elixir --version | tail -n1)"
	@printf '"elvish": "%s",\n' "$$(elvish --version)"
	@printf '"fish": "%s",\n' "$$(fish --version)"
	@printf '"godot": "%s",\n' "$$(godot -s --version)"
	@printf '"guile": "%s",\n' "$$(guile --version | head -n1)"
	@printf '"java": "%s",\n' "$$(java --version)"
	@printf '"julia": "%s",\n' "$$(julia --version)"
	@printf '"lua": "%s",\n' "$$(lua -v)"
	@printf '"luajit": "%s",\n' "$$(luajit -v)"
	@printf '"ngs": "%s",\n' "$$(ngs --version)"
	@printf '"nickel": "%s",\n' "$$(nickel --version)"
	@printf '"nim": "%s",\n' "$$(nim e --hints:off --version | head -n1)"
	@printf '"nix": "%s",\n' "$$(nix --version | tail -c 8 | tr -d ' ')"
	@printf '"node.js": "%s",\n' "$$(node --version)"
	@printf '"nu": "%s",\n' "$$(nu --version)"
	@printf '"ocaml": "%s",\n' "$$(ocaml -I +unix --version)"
	@printf '"osh": "%s",\n' "$$(osh --version | tr '\t' '\n' | head -n1)"
	@printf '"perl": "%s",\n' "$$(perl --version | head -n2 | tail -n1)"
	@printf '"php": "%s",\n' "$$(php --version | head -n1)"
	@printf '"python": "%s",\n' "$$(python3 --version)"
	@printf '"r": "%s",\n' "$$(Rscript --version | head -n1)"
	@printf '"racket": "%s",\n' "$$(racket --version)"
	@printf '"roc": "%s",\n' "$$(roc --version | head -n1)"
	@printf '"ruby": "%s",\n' "$$(ruby --version)"
	@printf '"rust": "%s",\n' "$$(rustc --version), $$(rust-script --version)"
	@printf '"scala": "%s",\n' "$$(scala-cli --version | tr '\n' ',')"
	@printf '"stack": "%s",\n' "$$(stack --version)"
	@printf '"swift": "%s",\n' \
		"$$(swift --version 2> /dev/null | head -n1 | tr -d '"')"
	@printf '"typst": "%s",\n' "$$(typst --version)"
	@printf '"v": "%s",\n' "$$(v --version)"
	@printf '"vala": "%s"\n' "$$(vala --version)"
	@echo "}"


.PHONY: run-compile-to-js
run-compile-to-js:
	hyperfine \
		--shell none \
		--warmup 10 \
		--export-json result.json \
		--prepare 'make clean' \
		'cd compile-to-js/elm && elm make src/Main.elm' \
		'cd compile-to-js/purescript && spago build' \
		'cd compile-to-js/rescript && npx rescript'


.PHONY: compile
compile:
	mkdir -p output/hello_world
	rm -f compiled/hello_world/*.o compiled/hello_world/*.hi
	CC=gcc ghc --make -O2 \
		-pgmc gcc -pgma gcc \
		-o output/hello_world/main-hs \
		compiled/hello_world/Main.hs
	mhs \
		-o output/hello_world/mainmicro-hs \
		compiled/hello_world/MainMicro.hs
	gcc -O2 \
		-o output/hello_world/main-c \
		compiled/hello_world/main.c
	rustc -O \
		-o output/hello_world/main-rust \
		compiled/hello_world/main.rs
	zig build-exe -O ReleaseFast \
		--name main-zig \
		--cache-dir output/zig-cache \
		compiled/hello_world/main.zig \
		&& mv main-zig output/hello_world/
	ocamlopt -O2 \
		-o output/hello_world/main-ocaml \
		compiled/hello_world/main.ml
	g++ -O2 \
		-o output/hello_world/main-cpp \
		compiled/hello_world/main.cpp
	nim compile -d:release \
		--out:output/hello_world/main-nim \
		compiled/hello_world/main.nim
	swiftc -O \
		-o output/hello_world/main-swift \
		compiled/hello_world/main.swift
	v -prod \
		-o output/hello_world/main-v \
		compiled/hello_world/main.v
	# crystal build --release \  # TODO: LLVM 22 broken in nixpkgs
	# 	-o output/hello_world/main-crystal \
	# 	compiled/hello_world/main.cr
	cd compiled/hello_world && fpc -O2 \
		-o../../output/hello_world/main-pascal \
		main.pas
	kotlinc compiled/hello_world/main.kt \
		-d output/hello_world/main-kotlin.jar
	mkdir -p output/hello_world/java-classes \
		&& javac -d output/hello_world/java-classes compiled/hello_world/Main.java \
		&& cd output/hello_world/java-classes \
		&& jar cf ../main-java.jar Main.class
	clang -O2 -framework Foundation \
		-o output/hello_world/main-objc \
		compiled/hello_world/main.m


.PHONY: run-hello-world
run-hello-world: compile
	hyperfine \
		--shell none \
		--warmup 10 \
		--export-json compiled/hello_world/result.json \
		'./output/hello_world/main-hs' \
		'./output/hello_world/mainmicro-hs' \
		'./output/hello_world/main-c' \
		'./output/hello_world/main-rust' \
		'./output/hello_world/main-zig' \
		'./output/hello_world/main-ocaml' \
		'./output/hello_world/main-cpp' \
		'./output/hello_world/main-nim' \
		'./output/hello_world/main-swift' \
		'./output/hello_world/main-v' \
		'./output/hello_world/main-pascal' \
		'java -cp output/hello_world/main-kotlin.jar MainKt' \
		'java -cp output/hello_world/main-java.jar Main' \
		'./output/hello_world/main-objc' \
		'bash ./shebang-scripts/hello_world/bash' \
		'dart run compiled/hello_world/main.dart' \
		'dash ./shebang-scripts/hello_world/dash' \
		'elixir ./shebang-scripts/hello_world/elixir' \
		'elvish ./shebang-scripts/hello_world/elvish' \
		'escript ./shebang-scripts/hello_world/erlang' \
		'fish ./shebang-scripts/hello_world/fish' \
		'dotnet fsi ./shebang-scripts/hello_world/fsharp.fsx' \
		'groovy ./shebang-scripts/hello_world/groovy' \
		'guile -s ./shebang-scripts/hello_world/guile' \
		'runhaskell compiled/hello_world/Main.hs' \
		'mhs -r compiled/hello_world/MainMicro.hs' \
		'janet ./shebang-scripts/hello_world/janet' \
		'java --source 11 ./shebang-scripts/hello_world/java' \
		'bun run ./shebang-scripts/hello_world/javascript-bun' \
		'node ./shebang-scripts/hello_world/javascript-node' \
		'jq -n -f ./shebang-scripts/hello_world/jq' \
		'julia ./shebang-scripts/hello_world/julia' \
		'ksh ./shebang-scripts/hello_world/ksh' \
		'lua ./shebang-scripts/hello_world/lua' \
		'luajit ./shebang-scripts/hello_world/luajit' \
		'luau ./shebang-scripts/hello_world/luau' \
		'make -f ./shebang-scripts/hello_world/make' \
		'nim r --hints:off compiled/hello_world/main.nim' \
		'nu ./shebang-scripts/hello_world/nushell' \
		'ocaml compiled/hello_world/main.ml' \
		'perl ./shebang-scripts/hello_world/perl' \
		'php compiled/hello_world/main.php' \
		'python3 ./shebang-scripts/hello_world/python' \
		'ruby ./shebang-scripts/hello_world/ruby' \
		'rust-script ./shebang-scripts/hello_world/rust-script' \
		'sqlite3 :memory: -init compiled/hello_world/main.sql ""' \
		'tclsh ./shebang-scripts/hello_world/tcl' \
		'tcsh ./shebang-scripts/hello_world/tcsh' \
		'uiua run compiled/hello_world/main.ua' \
		'v run compiled/hello_world/main.v' \
		'woxi run ./shebang-scripts/hello_world/wolfram-language-woxi' \
		'zsh ./shebang-scripts/hello_world/zsh'


.PHONY: run-shebangs-today
run-shebangs-today:
	cd shebang-scripts/today \
	&& hyperfine \
		--shell none \
		--warmup 10 \
		--export-json result.json \
		$$(grep -v '^#' _all_.txt)


.PHONY: run-shebangs-hello-world
run-shebangs-hello-world:
	cd shebang-scripts/hello_world \
	&& hyperfine \
		--shell none \
		--warmup 10 \
		--export-json result.json \
		$$(grep -v '^#' _all_.txt)


shebang-scripts/node_modules:
	cd shebang-scripts \
	&& bun install


shebang-scripts/today/chart.svg: shebang-scripts/node_modules
	bun run ./shebang-scripts/generate-chart.ts

compiled/hello_world/hello-world-chart.svg: shebang-scripts/node_modules flake.nix flake.lock
	bun run ./generate-hello-world-chart.ts

bucket-calc/chart.svg: shebang-scripts/node_modules
	bun run ./generate-bucket-calc-chart.ts

.PHONY: charts
charts: shebang-scripts/today/chart.svg compiled/hello_world/hello-world-chart.svg bucket-calc/chart.svg


# Run all scripts once to make sure they work
.PHONY: test
test:
	nix flake check --no-warn-dirty
	cd shebang-scripts/today \
	&& hyperfine \
		--shell none \
		--runs 1 \
		$$(grep -v '^#' _all_.txt)


.PHONY: format
format:
	echo "TODO"


.PHONY: clean
clean:
	rm -rf shebang-scripts/node_modules

	rm -rf compile-to-js/elm/elm-stuff
	rm -rf compile-to-js/elm/index.html

	rm -rf compile-to-js/purescript/.purs*
	rm -rf compile-to-js/purescript/.spago
	rm -rf compile-to-js/purescript/node_modules
	rm -rf compile-to-js/purescript/output

	rm -rf compile-to-js/rescript/lib
	rm -rf compile-to-js/rescript/node_modules

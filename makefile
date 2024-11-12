.PHONY: help
help: makefile
	@tail -n +4 makefile | grep ".PHONY"


.PHONY: run
run:
	@hyperfine \
		--shell=none \
		--warmup 10 \
		'python3 bucket-calc/main.py' \
		'node bucket-calc/main.js' \
		'deno run bucket-calc/main.ts' \
		'deno run bucket-calc/main.js' \
		'bun run bucket-calc/main.ts' \
		'bun run bucket-calc/main.js'\
		'lua bucket-calc/main.lua' \
		'nickel export bucket-calc/main.ncl' \
		'typst query --field=text --one bucket-calc/main.typ "<main>"'


# Print all language and tool versions as one JSON object
.PHONY: print-versions
print-versions:
	@echo '{'
	@printf '"hyperfine": "%s",\n' "$$(hyperfine --version)"
	@printf '"bash": "%s",\n' "$$(bash --version | head -n1)"
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
	@printf '"julia": "%s",\n' "$$(julia --version)"
	@printf '"lua": "%s",\n' "$$(lua -v)"
	@printf '"luajit": "%s",\n' "$$(luajit -v)"
	@printf '"ngs": "%s",\n' "$$(ngs --version)"
	@printf '"nickel": "%s",\n' "$$(nickel --version)"
	@printf '"nim": "%s",\n' "$$(nim e --hints:off --version | head -n1)"
	@printf '"node.js": "%s",\n' "$$(node --version)"
	@printf '"nu": "%s",\n' "$$(nu --version)"
	@printf '"ocaml": "%s",\n' "$$(ocaml -I +unix --version)"
	@printf '"osh": "%s",\n' "$$(osh --version | tr '\t' '\n' | head -n1)"
	@printf '"perl": "%s",\n' "$$(perl --version | head -n2 | tail -n1)"
	@printf '"php": "%s",\n' "$$(php --version | head -n1)"
	@printf '"python": "%s",\n' "$$(python3 --version)"
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


.PHONY: run-shebangs
run-shebangs:
	cd shebang-scripts/today \
	&& hyperfine \
		--shell none \
		--warmup 10 \
		--ignore-failure \
		--export-json result.json \
		$$(cat _all_.txt)


shebang-scripts/today/chart.svg:
	bun run ./shebang-scripts/generate-chart.ts


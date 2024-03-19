.PHONY: run
run:
	@hyperfine --version

	@python3 --version
	@printf "Node %s\n" $$(node --version)
	@echo $$(deno --version | awk '{printf "%s%s", (NR > 1 ? ", " : ""), $$0}')
	@printf "Bun %s\n" $$(bun --version)
	@lua -v
	@nickel --version
	@typst --version

	@echo "\n===== Running Benchmark ====="

	@hyperfine \
		--shell=none \
		--warmup 5 \
		'python3 bin-calculation.py' \
		'node bin-calculation.js' \
		'deno run bin-calculation.ts' \
		'deno run bin-calculation.js' \
		'bun run bin-calculation.ts' \
		'bun run bin-calculation.js'\
		'lua bin-calculation.lua' \
		'nickel export bin-calculation.ncl' \
		'typst query --field=text --one bin-calculation.typ "<main>"'


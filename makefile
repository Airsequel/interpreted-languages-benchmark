.PHONY: run
run:
	@nickel --version
	@python3 --version
	@lua -v
	@deno --version
	bun --version
	node --version
	@hyperfine --version

	@echo "\n===== Running Benchmark ====="

	@hyperfine \
		--shell=none \
		--warmup 5 \
		'nickel export bin-calculation.ncl' \
		'python3 bin-calculation.py' \
		'lua bin-calculation.lua' \
		'deno run bin-calculation.ts' \
		'deno run bin-calculation.js' \
		'bun run bin-calculation.ts' \
		'bun run bin-calculation.js'\
		'node bin-calculation.js'

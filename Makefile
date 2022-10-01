.PHONY: test submod
submod:
	git submodule init
	git submodule sync --recursive
test: submod
	./test.sh
test-watch:
	while :; do inotifywait -e move,modify,close_write -r --include=".*\.(vim|vader)" .; ./test.sh; done

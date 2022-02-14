.PHONY: test submod
submod:
	git submodule init
	git submodule sync --recursive
test: submod
	./test.sh

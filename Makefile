all : bktree.pyx
	python setup.py build_ext --inplace

clean :
	rm bktree.c bktree.html bktree.*.so

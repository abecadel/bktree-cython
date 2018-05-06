import timeit

from bktree import BKTree

british_dictionary = [a.strip() for a in open('dictionary')]
tree = BKTree()
tree.add(british_dictionary)

setup = """
from bktree import BKTree

british_dictionary = [a.strip() for a in open('dictionary')]
tree = BKTree()
tree.add(british_dictionary)
"""


def test_word(word, radius):
    perf = timeit.timeit(f'tree.search("{word}", {radius})', number=100, setup=setup)
    print(f'Performance of tree.search("{word}", {radius}) = {perf}')
    print(tree.search(f"{word}", 1))


if __name__ == "__main__":
    for w, r in [('cat', 1), ('paper', 1), ('elephant', 1), ('Africa', 1), ('cat', 2), ('paper', 2), ('elephant', 2), ('Africa', 2)]:
        test_word(w, r)

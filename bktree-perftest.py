import timeit

from bktree import BKTree

business_dictionary = [a.strip() for a in open('business-names.txt')]
tree = BKTree(sanitize=True)
tree.add(business_dictionary)

setup = """
from bktree import BKTree

business_dictionary = [a.strip() for a in open('business-names.txt')]
tree = BKTree(sanitize=True)
tree.add(business_dictionary)
"""


def test_word(word, radius):
    perf = timeit.timeit(f'tree.search("{word}", {radius})', number=100, setup=setup)
    print(f'Performance of tree.search("{word}", {radius}) = {perf}')
    print(tree.search(f"{word}", 1))


if __name__ == "__main__":
    for w, r in [
        ('walmart', 1),
        ('walmartt', 1),
        ('walmarttt', 2),
        ('walllrt', 2),
    ]:
        test_word(w, r)

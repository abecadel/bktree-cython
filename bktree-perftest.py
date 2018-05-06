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
    for w, r in [
        ('cat', 1),
        ('paper', 1),
        ('elephant', 1),
        ('Africa', 1),
        ('cat', 2),
        ('paper', 2),
        ('elephant', 2),
        ('Africa', 2),
        ('adam', 1),
        ('ethos', 1),
        ('demonstration', 1),
        ('Terrance', 1),
        ('revery', 1),
        ('darnedest', 1),
        ('legislating', 1),
        ('Rolando', 1),
        ('balalaika\'s', 2),
        ('swoop\'s', 2),
        ('bobsledding', 1),
        ('tribulations', 1),
        ('blunderer', 1),
        ('scholarship', 1),
        ('editors', 1),
        ('unendurable', 1)
    ]:
        test_word(w, r)

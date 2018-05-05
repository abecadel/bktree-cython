import timeit

setup = """
from bktree import BKTree

# http://en.wikibooks.org/wiki/Algorithm_implementation/Strings/Levenshtein_distance#Python
def levenshtein(s, t):
    m, n = len(s), len(t)
    d = [range(n + 1)]
    d += [[i] for i in range(1, m + 1)]

    for i in range(0, m):
        for j in range(0, n):
            cost = 1
            if s[i] == t[j]:
                cost = 0

            d[i + 1].append(min(d[i][j + 1] + 1,  # deletion
                                d[i + 1][j] + 1,  # insertion
                                d[i][j] + cost)  # substitution
                            )
    return d[m][n]
    
    
british_dictionary = [a.strip() for a in open('/usr/share/dict/british-english')]

tree = BKTree(levenshtein)
tree.add(british_dictionary)
"""

if __name__ == "__main__":
    # british_dictionary = [a.strip() for a in open('/usr/share/dict/british-english')]
    #
    # tree = BKTree(levenshtein)
    # tree.add(british_dictionary)
    # print(tree.search("cat", 1))
    # print(tree.search("paper", 2))

    perf = timeit.timeit('tree.search("cat", 1)', number=100, setup=setup)
    print(f'Performance of tree.search("cat", 1) = {perf}')

    perf = timeit.timeit('tree.search("paper", 2)', number=100, setup=setup)
    print(f'Performance of tree.search("paper", 2) = {perf}')

"""

"""

from collections import deque

def hamming_distance(l, r):
    """
    >>> hamming_distance('paper', 'paper')
    0
    >>> hamming_distance('paaer', 'paper')
    1
    >>> hamming_distance('paperr', 'paper')
    1
    >>> hamming_distance('pape', 'paper')
    1
    >>> hamming_distance('peeer', 'paper')
    2
    >>> hamming_distance('pap', 'paper')
    2
    >>> hamming_distance('paperrr', 'paper')
    2

    :param l:
    :param r:
    :return:
    """
    l = list(l)
    r = list(r)
    l_len = len(l)
    r_len = len(r)

    distance = l_len - r_len

    if distance < 0:
        distance = -distance
    elif distance > 0:
        l_len = r_len

    for i in range(l_len):
        if l[i] is not r[i]:
            distance += 1

    return distance


class BKTree:
    """
    >>> tree = BKTree(words=['paper','paaer','paaar'])
    >>> tree.search('paper', 2)
    [(0, 'paper'), (1, 'paaer'), (2, 'paaar')]

    """

    def __init__(self, distance_func=hamming_distance, words=None, sanitize=False):
        """

        :param distance_func:
        :param words:
        :param sanitize:
        """
        self._tree = None
        self._distance_func = distance_func
        self.sanitize = sanitize

        if words is not None:
            self.add(words)

    def add(self, words):
        """

        :param node:
        :return:
        """
        if type(words) is list:
            for word in words:
                self.__add(word)
        else:
            self.__add(words)

    def __add(self, node):
        if self.sanitize is True:
            node = node.strip().lower()

        if self._tree is None:
            self._tree = (node, {})
            return

        current, children = self._tree
        while True:
            dist = self._distance_func(node, current)
            target = children.get(dist)
            if target is None:
                children[dist] = (node, {})
                break
            current, children = target

    def search(self, node, radius):
        """

        :param node:
        :param radius:
        :return:
        """

        if self.sanitize is True:
            node = node.strip().lower()

        if self._tree is None:
            return []

        candidates = deque([self._tree])
        result = []
        while candidates:
            candidate, children = candidates.popleft()
            dist = self._distance_func(node, candidate)
            if dist <= radius:
                result.append((dist, candidate))

            low, high = dist - radius, dist + radius
            candidates.extend(c for d, c in children.items() if low <= d <= high)
        return result


if __name__ == '__main__':
    import doctest

    doctest.testmod()

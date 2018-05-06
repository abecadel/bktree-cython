from collections import deque

def hamming_distance(l, r):
    """
    >>> zero = 'paper'
    >>> ones = ['paaer', 'paperr', 'pape']
    >>> twos = ['peeer', 'pap']
    >>> hamming_distance(zero, 'paper')
    0
    >>> hamming_distance(ones[0], 'paper')
    1
    >>> hamming_distance(ones[1], 'paper')
    1
    >>> hamming_distance(ones[2], 'paper')
    1
    >>> hamming_distance(twos[0], 'paper')
    2
    >>> hamming_distance(twos[1], 'paper')
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

    """

    def __init__(self, distance_func=hamming_distance, words=None):
        """

        :param distance_func:
        """
        self._tree = None
        self._distance_func = distance_func

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
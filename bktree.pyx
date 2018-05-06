from collections import deque

def hamming_distance(l, r):
    """

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

    def __init__(self, distance_func=hamming_distance):
        """

        :param distance_func:
        """
        self._tree = None
        self._distance_func = distance_func

    def add(self, node):
        """

        :param node:
        :return:
        """
        if type(node) is list:
            for word in node:
                self.__add(word)
        else:
            self.__add(node)

    def __add(self, node):
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
            candidates.extend(c for d, c in children.items()
                              if low <= d <= high)
        return result

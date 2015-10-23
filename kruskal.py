#This class represent a single node within an undirected graph
class Node:
    def __init__(self):
        self.key = 0

    def __init__(self, key):
        self.key = key

#This class represent a single edge within an undirected graph
class Edge:
    def __init__(self):
        self.cost = 0
        self.n1 = None
        self.n2 = None

    def __init__(self, cost, n1, n2):
        self.cost = cost
        self.n1 = n1
        self.n2 = n2

def compareTo(e1, e2):
    if e1.cost >= e2.cost:
        return False
    return True

def kruskal(nodes, edges):
    n = nodes.length
    SORTED_EDGES = edges.sort(compareTo) #O(m*log(m))

    #Initialization of S to keep track of the connected components
    S = dict()
    for n in nodes:
        S.append(n,S.length)

    R = []

    while R.length < n:
        curr_edge = SORTED_EDGES.pop() #The minimum costing edge

        #Is the selected edge endpoints connected in two separated connected components? (ie. is it creating a cycle?)
        if S.get(curr_edge.n1) != S.get(curr_edge.n2):
            sub = S.get(curr_edge.n2)
            actual = S.get(curr_edge.n1)
            #The new edge is NOT creating a cycle
            #So we merge the two connected components
            for e in S:
                if e.value == sub:
                    e.value = actual
            #curr_edge is selected as a component of the minimum spanning tree
            R.append(curr_edge)
        pass
    #The while cost O(n^2)
    #So the total complexity is O(m*logm + n^2)

    return R

####
#   MAIN
####

if __name__ == "__main__":
    #TODO

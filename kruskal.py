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

def kruskal(nodes, edges):
    n = nodes.length
    SORTED_EDGES = sort(edges,key) #??
    #Initialization of S, that is the container of the single connected component
    S = range(n)
    R = []
    while R.length < n:
        curr_edge = SORTED_EDGES.pop() #The minimum costing edge
        
        pass

####
#   MAIN
####

if __name__ == "__main__":
    #TODO

#!/usr/bin/python3.5
from graph import *
import math

#Note on complexity: getEdgeFromEndPoints is O(1) if the graph is represented in a matrix
def dijkstra(nodes, edges, source):
    n = len(nodes)
    m = len(edges)
    R = [] #Result list: contains the edges composing the shortest path
    C = [0]*n #C[i] contains the cost from source to node i via the shortest path
    P = [None]*n #P[i] contains the predecessor of node i
    S = [source]

    while len(S) != n:

        min_cost = math.inf
        for e in edges:
            if e.n1 in S and not(e.n2 in S):
                if (e.cost + C[nodes.index(e.n1)])  <= min_cost:
                    min_cost = e.cost + C[nodes.index(e.n1)]
                    min_edge = e
                    min_node = e.n2

        P[nodes.index(min_node)] = min_edge.n1
        C[nodes.index(min_node)] = C[nodes.index(min_edge.n1)]+min_edge.cost
        S.append(min_node)

        pass

    return [P,C]

def generatePath(nodes, edges, start, end):
    [P,C] = dijkstra(nodes,edges,start)
    cost = C[nodes.index(end)]
    path = [end]
    p = P[nodes.index(end)]

    while p != start:
        path.append(p)
        p = P[nodes.index(p)]
        cost += C[nodes.index(p)]
    path.append(start)
    path.reverse()
    
    for n in path:
        if n != end: print("Node "+str(n.key) + "->",end="")
    print("Node "+str(end.key))
    print("Total cost: " + str(cost))


####
#   MAIN
####

if __name__ == "__main__":
    #Building a generic graph
    n1 = Node(1)
    n2 = Node(2)
    n3 = Node(3)
    n4 = Node(4)
    n5 = Node(5)

    e1 = Edge(2,n1,n2)
    e2 = Edge(4,n1,n3)
    e3 = Edge(1,n4,n1)
    e4 = Edge(5,n5,n1)
    e5 = Edge(6,n2,n3)
    e6 = Edge(2,n2,n4)
    e7 = Edge(4,n5,n2)
    e8 = Edge(2,n3,n5)
    e9 = Edge(1,n4,n3)
    e10 = Edge(10,n5,n4)

    nodes = [n1,n2,n3,n4,n5]
    edges = [e1,e2,e3,e4,e5,e6,e7,e8,e9,e10]

    generatePath(nodes,edges,n1,n5)

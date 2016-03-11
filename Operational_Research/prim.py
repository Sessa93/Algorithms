#!/usr/bin/python3.5
from graph import *
import math

#Find a minimum spanning tree of a given graph G
def prim(Nodes, Edges, root):
    S = [root]
    R = []

    while len(R) < len(Nodes)-1:
        min_c = math.inf
        for e in Edges:
            if (e.n1 in S and not(e.n2 in S)) or (e.n2 in S and not(e.n1 in S)):
                if e.cost <= min_c:
                    min_c = e.cost
                    min_e = e
        if min_e.n1 in S:
            S.append(min_e.n2)
        else:
            S.append(min_e.n1)
        R.append(min_e)
        pass
    return R

if __name__ == "__main__":
    #Building a generic graph
    n1 = Node(1)
    n2 = Node(2)
    n3 = Node(3)
    n4 = Node(4)
    n5 = Node(5)

    e1 = Edge(2,n1,n2)
    e2 = Edge(4,n1,n3)
    e3 = Edge(1,n1,n4)
    e4 = Edge(5,n1,n5)
    e5 = Edge(6,n2,n3)
    e6 = Edge(2,n2,n4)
    e7 = Edge(4,n2,n5)
    e8 = Edge(2,n3,n5)
    e9 = Edge(1,n3,n4)
    e10 = Edge(10,n4,n5)

    nodes = [n1,n2,n3,n4,n5]
    edges = [e1,e2,e3,e4,e5,e6,e7,e8,e9,e10]

    R = prim(nodes,edges,n1)

    t_cost = 0
    for e in R:
        t_cost += e.cost
        print(str(e.n1.key) + " -> " + str(e.n2.key))
    print("Total cost: "+str(t_cost))

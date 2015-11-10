#!/usr/bin/python3.5
from graph import *
import math

#Assuming that the input graph is a DAG
def top_order(nodes, edges):
    N = []
    while len(N) < len(nodes):
        for n in nodes:
            not_found = False
            for m in edges:
                if m.n2 == n:
                    not_found = True
            if not(not_found):
                N.append(n)
        pass


#Find a minimum cost path assuming that the input graph is a DAG
def dynamic(nodes, edges, source, end, C):
    ord_nodes = top_order(nodes, edges)
    for n in ord_nodes:
        if n == source:
            C[n] = 0



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

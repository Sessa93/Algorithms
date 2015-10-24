#!/usr/bin/python3.5
from graph import *
import math

#Computes the set of nodes reachable from n1
def reachable(n1, edges):
    R = []
    for e in edges:
        if e.n1 == n1:
            R.append(e.n2)
    return R

def getCostFromEndpoints(edges, n1, n2): #In constant time if we use an adjiacency matrix
    edge = getEdgeFromEndPoints(edges,n1,n2)
    if edge != None: return edge.cost
    return math.inf

def getEdgeFromEndPoints(edges, n1, n2):
    for e in edges:
        if e.n1 == n1 and e.n2 == n2:
            return e
    else:
        return None

def dijkstra(nodes, edges, source):
    n = len(nodes)
    m = len(edges)
    R = [] #Result list: contains the edges composing the shortest path
    C = [0]*n #C[i] contains the cost from source to node i
    P = [0]*n #P[i] contains the predecessor of node i
    S = [source]

    for i in range(n):
        if nodes[i] != source:
            C[i] = getCostFromEndpoints(edges,source,nodes[i])
        else:
            C[i] = math.inf

    curr_pred = source
    while len(S) != n:
        #Searching the minimum edge belonging to delta+(S)
        mn = math.inf
        for j in range(n):
            if C[j] <= mn and not(nodes[j] in S):
                mn = C[j]
                mn_node_index = j
                minimum_node = nodes[j]

        starting_node = 
        S.append(minimum_node)
        pass

    return P

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

    R = dijkstra(nodes,edges,n1)

    print(R)

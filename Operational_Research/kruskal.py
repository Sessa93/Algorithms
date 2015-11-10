#!/usr/bin/python3.5
from graph import *

def compareTo(e):
    return e.cost

def kruskal(nodes, edges):

    SORTED_EDGES = sorted(edges, key=compareTo, reverse=True) #O(m*log(m))

    #Initialization of S to keep track of the connected components
    S = dict()
    for n in nodes:
        S[n] = len(S)

    R = []
    n = len(nodes)

    while len(R) < n-1:
        curr_edge = SORTED_EDGES.pop() #The minimum costing edge

        #Is the selected edge endpoints connected in two separated connected components? (ie. is it creating a cycle?)
        if S.get(curr_edge.n1) != S.get(curr_edge.n2):
            sub = S.get(curr_edge.n2)
            actual = S.get(curr_edge.n1)
            #The new edge is NOT creating a cycle
            #So we merge the two connected components
            for k,v in S.items():
                if v == sub:
                    S[k] = actual
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

    R = kruskal(nodes,edges)

    t_cost = 0
    for e in R:
        t_cost += e.cost
        print(str(e.n1.key) + " -> " + str(e.n2.key))
    print("Total cost: "+str(t_cost))

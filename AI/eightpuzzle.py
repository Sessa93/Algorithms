#8-Puzzles state space search problem

class Action:
    def __init__(self, name):
        self.name = name

    def getName():
        return self.name

class Node:
    def __init__(self, state, g_cost, lastAction, parent, h_cost):
        self.S = state
        self.cost = cost
        self.lastAction = lastAction
        self.parent = parent

    def getState():
        return self.S

    def getTotalCost():
        return self.g_cost

    def getEuristicsCost():
        return self.g_cost + self.h_cost;

    def getLastAction():
        return self.lastAction

    def getParent():
        return self.parent

    def equals(node):
        if node.getState == self.S:
            return True
        return False

def getZeroTilePos(state):
    for i in range(len(state)):
        for j in range(len(state)):
            if(state[i][j] == 0) return [i,j]
    return None

def Action(state):
    R = []
    pos = getZeroTilePos(state)
    if pos[0] < len(state):
        R.appen(Action("DOWN"))
    if pos[0] > 0:
        R.append(Action("UP"))
    if pos[1] < len(state):
        R.append(Action("RIGHT"))
    if pos[1] > 0:
        R.append(Action("LEFT"))
    return R

def Result(state, action):
    if action in Action(state):
        pos = getZeroTilePos(state)
        if action.getName == "UP":
            tmp = state[pos[0]-1][pos[1]]
            state[pos[0]-1][pos[1]] = 0
        else if action.getName == "LEFT":
            tmp = state[pos[0]][pos[1]-1]
            state[pos[0]][pos[1]-1] = 0
        else if action.getName == "RIGHT":
            tmp = state[pos[0]][pos[1]+1]
            state[pos[0]][pos[1]+1] = 0
        else: #DOWN
            tmp = state[pos[0]+1][pos[1]]
            state[pos[0]][pos[1]+1] = 0
        state[pos[0]][pos[1]] = tmp
    return None

def Cost(state, action):
    return 1

#Returns the expected cost from the current state to a goal(s)
def euristics_h_1(state):
    e = 1
    cost = 0
    for i in range(len(state)):
        for j in range(len(state)):
            if state[i][j] != e:
                cost += 1
            e += 1
    return cost

def getMinimumNode(frontier):
    min_c = math.inf
    for n in frontier:
        if n.getEuristicsCost() < min_c:
            min_n = n
            min_c = n.getEuristicsCost()
    frontier.remove(min_n)
    return min_n



#A graph search algorithm implementing an A* strategy by means of the euristics h_1
def graphSearch(source, goal, frontier):
    if source.equals(goal):
        return goal

    expanding_node = getMinimumNode(frontier)

    #Keep the optimality of A*
    if expanding_node.getState.equals(goal):
        return goal

    actions = Action(expanding_node.getState())

    for a in actions:
        

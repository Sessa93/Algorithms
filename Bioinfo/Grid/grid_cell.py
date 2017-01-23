from Direction import Direction

class GridCell:

    def __init__(self, score, directions):
        self.score = int(score)
        self.directions = directions

    def setDirection(self, direction):
        self.directions.append(direction)

# Author Andrea Sessa
# This script perform an alignment(global or local) between two arbitrary
# sequences (nucleotides or amino-acids) using the grid method.

import sys, argparse
import numpy as np
from grid_cell import GridCell
from Direction import Direction
import matplotlib.pyplot as plt

def main():
    # Parser for command line arguments
    parser = argparse.ArgumentParser(description='Process input sequences and method')
    parser.add_argument('S1',metavar='Seq1', help='First sequence to align')
    parser.add_argument('S2',metavar='Seq2', help='Second sequence to align')
    parser.add_argument('GAP', metavar='gap', help='Gap penalty', type=int)
    parser.add_argument('--local', dest='local_threshold', type=int, action='store', help='Alignment method is local(default global), LOCAL_THRESHOLD specify the threshold for the alignment')
    parser.add_argument('--blosum62', dest='blosum', action='store_true', help='The substitution matrix is BLOSUM62, default PAM250')
    parser.add_argument('--test', dest='test', action='store_true', help='Load the test matrix, default PAM250')
    args = parser.parse_args()

    if args.blosum:
        sub_matrix = getBlosum62()
    elif args.test:
        sub_matrix = getTestMatrix()
    else:
        sub_matrix = getPam250()

    if args.local_threshold:
        local_align(args.S1, args.S2, args.GAP, sub_matrix, args.local_threshold)
    else:
        global_align(args.S1, args.S2, args.GAP, sub_matrix)

def getBlosum62():
    blosum_file = open('blosum62', 'r')
    blosum_matrix = dict()

    amino = True
    for line in blosum_file.readlines():
        if not(line.startswith('#')) and len(line) > 1:
            if amino:
                amino_acids = line.split()
                amino = False
            else:
                scores = line.split()
                line_amino = scores[0]
                for ii in range(1,24):
                    blosum_matrix[line_amino, amino_acids[ii-1]] = scores[ii]
    blosum_file.close()
    return blosum_matrix


def getTestMatrix():
    test_file = open('testMat', 'r')
    test_matrix = dict()

    amino = True
    for line in test_file.readlines():
        if not(line.startswith('#')) and len(line) > 1:
            if amino:
                amino_acids = line.split()
                amino = False
            else:
                scores = line.split()
                line_amino = scores[0]
                for ii in range(1,5):
                    test_matrix[line_amino, amino_acids[ii-1]] = scores[ii]
    test_file.close()
    return test_matrix

def getPam250():
    pam_file = open('pam250', 'r')
    pam_matrix = dict()

    amino = True
    for line in pam_file.readlines():
        if not(line.startswith('#')) and len(line) > 1:
            if amino:
                amino_acids = line.split()
                amino = False
            else:
                scores = line.split()
                line_amino = scores[0]
                for ii in range(1,24):
                    pam_matrix[line_amino, amino_acids[ii-1]] = scores[ii]
    pam_file.close()
    return pam_matrix

def local_align(S, T, gap, matrix, threshold):
    # Initialization
    grid = dict()

    for jj in range(len(S)+1):
        grid[0,jj] = GridCell(0, [Direction.NONE])

    for ii in range(len(T)+1):
        grid[ii,0] = GridCell(0, [Direction.NONE])
    # End Initialization

    for ii in range(1,len(T)+1):
        for jj in range(1,len(S)+1):
            score = grid[ii-1, jj-1].score + int(matrix[S[jj-1], T[ii-1]])
            direction = [Direction.DIAG]

            if (grid[ii-1, jj].score + gap) > score:
                score = grid[ii-1, jj].score + gap
                direction = [Direction.BOTTOM]
            elif grid[ii-1, jj].score + gap == score:
                direction.append(Direction.RIGHT)

            if (grid[ii,jj-1].score + gap) > score:
                score = grid[ii,jj-1].score + gap
                direction = [Direction.BOTTOM]
            elif (grid[ii,jj-1].score + gap) == score:
                direction.append(Direction.RIGHT)

            if score <= 0:
                score = 0
                direction = [Direction.NONE]

            grid[ii, jj] = GridCell(score, direction)

    for ii in range(1,len(T)+1):
        for jj in range(1,len(S)+1):
            if grid[ii,jj].score >= threshold:
                traceback(S, T, grid, ii, jj,'', '')
    plot(grid,S,T)

def global_align(S, T, gap, matrix):
    # Initialization
    grid = dict()
    grid[0,0] = GridCell(0, [Direction.NONE])
    for jj in range(1,len(S)+1):
        grid[0,jj] = GridCell(gap*jj, [Direction.RIGHT])

    for ii in range(1,len(T)+1):
        grid[ii,0] = GridCell(gap*ii, [Direction.BOTTOM])
    # End Initialization

    for ii in range(1,len(T)+1):
        for jj in range(1,len(S)+1):
            score = grid[ii-1, jj-1].score + int(matrix[S[jj-1], T[ii-1]])
            direction = [Direction.DIAG]

            if (grid[ii-1, jj].score + gap) > score:
                score = int(grid[ii-1, jj].score + gap)
                direction = [Direction.BOTTOM]
            elif grid[ii-1, jj].score + gap == score:
                direction.append(Direction.BOTTOM)

            if (grid[ii,jj-1].score + gap) > score:
                score = int(grid[ii,jj-1].score + gap)
                direction = [Direction.RIGHT]
            elif (grid[ii,jj-1].score + gap) == score:
                direction.append(Direction.RIGHT)

            grid[ii, jj] = GridCell(score, direction)

    traceback(S, T, grid, ii, jj,'', '')
    plot(grid,S,T)

def traceback(S, T, grid, i, j, alignmentS, alignmentT):
    if Direction.NONE in grid[i,j].directions:
        print('New Alignment Found!')
        print(alignmentS[::-1])
        print(alignmentT[::-1]+'\n')
    else:
        cell = grid[i,j]
        for d in cell.directions:
            if d == Direction.DIAG:
                traceback(S,T,grid,i-1,j-1,alignmentS + S[j-1],alignmentT + T[i-1])
            elif d == Direction.BOTTOM:
                traceback(S,T,grid,i-1,j,alignmentS + '-',alignmentT + T[i-1])
            else:
                traceback(S,T,grid,i,j-1,alignmentS + S[j-1],alignmentT + '-')

def plot(grid,S, T):
    #Extract the scores
    scores = []
    fig, ax = plt.subplots()

    for ii in range(len(T)+1):
        row = []
        for jj in range(len(S)+1):
            ax.text(jj-0.15,ii+0.1,str(grid[ii,jj].score))
            row.append(grid[ii,jj].score)
            for d in grid[ii,jj].directions:
                if d == Direction.DIAG and ii > 0 and jj > 0:
                    ax.arrow((jj-1)+0.2,(ii-1)+0.2, 0.5, 0.5, head_width=0.2, head_length=0.1, fc='k', ec='k')
                elif d == Direction.BOTTOM and ii > 0:
                    ax.arrow(jj+0.1,(ii-1)+0.2, 0, 0.5, head_width=0.2, head_length=0.1, fc='k', ec='k')
                elif jj > 0 and d == Direction.RIGHT:
                    ax.arrow((jj-1)+0.3,ii+0.2, 0.5, 0, head_width=0.2, head_length=0.1, fc='k', ec='k')
        scores.append(row)

    ax.matshow(scores)
    labels_x = ['']+[c for c in S]
    labels_y = ['']+[c for c in T]
    ax.set_xticks(np.arange(0, len(S)+1, 1))
    ax.set_yticks(np.arange(0, len(T)+1, 1))
    ax.set_xticklabels(labels_x)
    ax.set_yticklabels(labels_y)
    plt.show()

if __name__ == "__main__":
    main()

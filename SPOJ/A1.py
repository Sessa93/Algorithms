import math

def search(A,e):
    n = len(A)
    if e > A[n-1]:
        return -1
    if e < A[0]:
        return A[0]
    if e < A[n-1] and e > A[n-2]:
        return A[n-1]

    found = -1
    a = 0
    b = n-1
    while found == -1:
        m = math.floor((a+b)/2)
        if A[m] == e or (A[m-1] < e and A[m] > e):
            found = m
        else:
            if e > A[m]:
                a = m
            else:
                b = m
    return A[found]


def main():
    A = [11,29,31,40,54,63,78,80,91]
    n = int(input())
    print(search(A,n))

if __name__ == '__main__':
    main()

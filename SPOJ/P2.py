# TO DO: too slow!

import math
import time

def sieve(u):
	prime[0] = False
	prime[1] = False
	for i in range(2,u):
		if prime[i]:
			j = i*i
			while j <= u:
				prime[j] = False
				j += i


def segmentedSieve2(m,n):
	lim = math.ceil(math.sqrt(n))
	sieve(lim)
	for i in range(2,lim):
		if prime[i]:
			j = m - (m%i)
			while j <= n:
				if j >= m and prime[j] and j != i:
					prime[j] = False
				j += i

n = int(input())

i = 0
a = []
b = []
while i < n:
	S = input().split()
	a.append(int(S[0]))
	b.append(int(S[1]))
	i += 1

start_time = time.time()
i = 0
while i < n:
	prime = [True]*(b[i]+1)
	segmentedSieve2(a[i],b[i])
	for p in range(b[i]+1):
		if p >= a[i] and p <= b[i] and prime[p]:
			print(p)
	print("")
	i += 1
#print("--- %s seconds ---" % (time.time() - start_time))

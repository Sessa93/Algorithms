#include <stdio.h>
#include <stdlib.h>

int sarr(int A[], int p, int q)
{
	int i, sum = 0;
	for(i = p; i <= q; i++) sum += A[i];
	return sum;
}

int CHECK(int A[], int p, int q)
{
	int s1 = sarr(A,p,q-1);
	int s2 = A[q];
	q--;
	while(q > 0)
	{
		if(s2 == s1) return 1;
		s1 = s1 - A[q];
		s2 = s2 + A[q];
		q--;
	}
	return 0;
}

void SUMARR(int A[],int n, int *p, int *q)
{
	int i=0,j=0;
	int maxi=i, maxj=j;
	for(i = 0; i < n; i++)
	{
		for(j = 0; j < n; j++)
		{
			if(i != j && CHECK(A,i,j))
			{
				if(j-i >= maxj-maxi)
				{
					maxj = j;
					maxi = i;
				}
			}	
		}
	}
	*p = maxi;
	*q = maxj;
}


int main()
{	
	int A[] = {1,2,3,1,2,3,4};
	int i,j;
	SUMARR(A,7,&i,&j);
	printf("I: %d, J: %d\n",i,j);
}	

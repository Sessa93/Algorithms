#include <stdio.h>
#include <stdlib.h>

void max_seq(int A[], int n, int *h, int *k)
{
	int i = 0;
	int j = 0;
	int maxi = i, maxj = j;
	while(i < n && j < n)
	{
		if(A[j] > A[i]) j++;
		else
		{
			if(i != j) i++;
			else j++;
		}	
		if(j-i >= maxj-maxi+1)
		{
			maxj = j-1;
			maxi = i;
		}

	}
	*h = maxi;
	*k = maxj;
}


int main()
{
	int A[] = {100,4,5,6,1,10,-1};
	int i,j;
	max_seq(A,7,&i,&j);
	printf("Ris-> i: %d, j: %d\n",i,j);
	return 0;
}

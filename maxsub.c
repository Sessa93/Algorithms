//#include "sort.c"
#include <stdio.h>


int ninv(int A[], int n)
{
	int i,j,I=0;
	for(i = 0; i < n; i++)
	{
		for(j = i; j < n; j++)
			if(A[j] < A[i] && i != j) I++;
	}
	return I;
}

int main()
{
	int x;
	int A[] = {10,9,8,7,6,5,4,3,2,1};
	printf("\nRis: %d\n",ninv(A,10));
}

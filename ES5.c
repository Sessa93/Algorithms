#include <stdio.h>
#include <stdlib.h>

int SUM_UP(int A[], int i, int j)
{
	int i,s=0;
	for(i = i; i <= j; i++) s += A[i];
	return s; 
}

int CHECK(int A[], int i, int j)
{
	int k;
	int sl = A[i], sr = A[j];
	for(k = i+1; k <= j; k++)
	{
		if(sl == sr) return 1;
		sl = sl + A[i];
		sr = sr + A[j		
	}
	return 0;
}

int FUN(int A[], int n)
{
	int i,j;
	for(i = 0; i < n; i++)
	{
		for(j = i+1; j < n; j++)
		{
			return CHECK(A,i,j);
		}
	}
	return 0;
}



int main()
{
	int A[] = {1,2,3,4,5,6,7,8,9,10};
	FUN(A,10);
	return 0;
}

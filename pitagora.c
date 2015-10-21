#include "merge_sort.c"

int SOMMA(int A[],int p, int x)
{
	int i = p;
	int j = 0;
	while(j < i)
	{
		if((A[i]*A[i])+(A[j]*A[j]) == x*x) return 1;
		else
		{
			if((A[i]*A[i])+(A[j]*A[j]) < x*x) j++;
			else i--;
		}
	}
	return 0;
}

int pitagora(int A[], int n)
{
	int i,j,x;
	if(n < 3) return 0;
	merge_sort_ric(A,n);
	i = 1;
	while(i < n)
	{
		if(SOMMA(A,i-1,A[i])) return 1;
		else i++;
	}
	return 0;
}


int main()
{	
	int A[] = {3,0,3,1,1};
	printf("RIS: %d\n",pitagora(A,5));
	visua(A,5);
	return 0;
}	

//#include "sort.c"
#include <stdio.h>


int ex_sum(int A[], int x, int i, int j)
{
	//SORT(A)
	if((j-i) < 2) return 0;
	while(i != j)
	{
		if(A[i] + A[j] == x) return 1;
		if(A[i] + A[j] > x) j--;
		else i++;
	}
	return 0;
}

int main()
{
	int x;
	int A[] = {1,2,3,4,5,6,7,8,9,10};
	printf("Inserisci un numero: ");
	scanf("%d",&x);
	printf("\nRis: %d\n",ex_sum(A,x,0,9));
}

#include <stdio.h>

int b_search(int A[], int i, int j, int e)
{
	int m = (i+j)/2;
	if(e == A[m]) return m;
	if(i == j) return -1;
	if(e > A[m]) return b_search(A,m+1,j,e);
	return b_search(A,i,m-1,e);
}

int main()
{
	int A[] = {1,2,3,4,5,6,7,8,9,10};
	int n;
	printf("Inserisci un numero: ");
	scanf("%d",&n);
	printf("\nIndice: %d\n",b_search(A,0,9,n));
}

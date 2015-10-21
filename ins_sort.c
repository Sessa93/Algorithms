#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


void ins_sort(int A[], int n)
{
	int i,k,j;
	for(i = 1; i < n; i++)
	{
		k = A[i];
		j = i-1;
		while(j >= 0 && A[j] >= k)
		{
			A[j+1] = A[j];
			j--;
		}
		A[j+1] = k;
	}
}

void visua(int A[], int n)
{
	int i;
	printf("[");
	for(i = 0; i < n-1; i++)
	{
		printf("%d,",A[i]);
	}
	printf("%d]\n", A[n-1]);
}

int main()
{
	int n,i,tmp;
	int A[100];
	printf("Inserisci n: ");
	scanf("%d",&n);
	for(i = 0; i < n; i++)
	{
		/*printf("Inserisci un elemento: ");
		scanf("%d",&A[i]);*/
		A[i] = rand();
	}
	printf("\nArray non ordinato: \n");
	visua(A,n);
	ins_sort(A,n);
	printf("Array ordinato: \n");
	visua(A,n);

}

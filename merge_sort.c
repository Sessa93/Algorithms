#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdint.h>
#include "heap_sort.c"

#define DIM 55000
#define BILLION 1000000000L

void merge(int A[], int B[], int C[], int na, int nb, int nc)
{
	//A e B sottoarray ordinati, in C la fusione
	int i=0,j=0,k=0;
	while(i < na && j < nb)
	{
		if(A[i] >= B[j])
		{
			C[k] = B[j];
			j++;			
		}
		else
		{
			C[k] = A[i];
			i++;
		}
		k++;
	}
	if(i == na && j < nb)
	{
		while(j < nb)
		{
			C[k] = B[j];
			j++;
			k++;
		}
	}

	if(j == nb && i < na)
	{
		while(i < na)
		{
			C[k] = A[i];
			i++;
			k++;
		}
	}
}

void merge_sort_ric(int A[], int n)
{
	int m,h,k,B[DIM],C[DIM];
	if(n > 1)
	{
		m = n/2;
		for(h = 0; h < m; h++)
			B[h] = A[h];
		for(k = m; k < n; k++)
			C[k-m] = A[k];  
		merge_sort_ric(B,h);
		merge_sort_ric(C,k-m);
		merge(B,C,A,h,k-m,n);
	}
}

void merge_2(int A[], int i1, int j1, int i2, int j2)
{
	int i=0,j=0,k=0;
	int C[100];
	int na = j1-i1;
	int nb = j2-i2;

	while(i < na && j < nb)
	{
		if(A[i+i1] >= A[j+i2])
		{
			C[k] = A[j+i2];
			j++;			
		}
		else
		{
			C[k] = A[i+i1];
			i++;
		}
		k++;
	}
	if(i == na && j < nb)
	{
		while(j < nb)
		{
			C[k] = A[j+i2];
			j++;
			k++;
		}
	}

	if(j == nb && i < na)
	{
		while(i < na)
		{
			C[k] = A[i+i1];
			i++;
			k++;
		}
	}
	for(i = i1; i < (j2); i++)
		A[i] = C[i-i1];

}

void visua2(int A[], int n)
{
	int i;
	printf("[");
	for(i = 0; i < n-1; i++)
	{
		printf("%d,",A[i]);
	}
	printf("%d]\n", A[n-1]);
}


void merge_sort_it(int A[], int n)
{
	int i,k = 1,j,c=0;
	int m = n/2;
	//int B[100],C[100];
	while(k <= n)
	{
		for(i = 0; i < n; i = i+k+k)
		{
			//for(j = 0; j < k; j++) B[j] = A[j+i];
			//for(j = 0; j < k; j++) C[j] = A[j+i+k];
			if(k > m) k = m;
			merge_2(A,i,i+k,i+k,i+k+k);
			visua(A,n);
			//k = k*2;
			//i = i+k;
		
		}
		k = k*2;
	}
}


int main()
{
	FILE *ris;
	ris = fopen("merge.txt", "w");
	int n,i,tmp,j;
	int A[DIM];
	//printf("Inserisci n: ");
	//scanf("%d",&n);
	uint64_t diff;
	struct timespec start, end;
	for(i = 1; i < DIM; i+=1500)
	{	
		for(j = 0; j < i; j++) A[j] = i-j;
		clock_gettime(CLOCK_MONOTONIC, &start);
		merge_sort_ric(A,i);
		clock_gettime(CLOCK_MONOTONIC, &end);
		diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
		fprintf(ris,"%d %llu\n",i,(long long unsigned int)diff);
		
	}
}

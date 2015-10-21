//#include "sort.c"
#include <stdio.h>
#include <stdlib.h>
#define N 5

struct NODE
{
	//0 nero
	//1 grigio
	//2 bianco
	int C;
	int K;
};

int aciclic(int EDGES[N][N], struct NODE* NODES[])
{
	int i;
	for(i = 0; i < N; i++)
		return DFV(i, EDGES, NODES);	
}

int DFV(int S, int EDGES[N][N], struct NODE* NODES[])
{
	int i,R;
	NODES[S]->C = 1;
	for(i = 0; i < N; i++)
	{
		if(EDGES[S][i])
		{
			if(NODES[i]->C == 2)
			{
				R = DFV(i,EDGES,NODES);
				if(!R) return 0;
			}
			else
			{
				if(NODES[i]->C == 1) return 0;
			}
		}
	}
	NODES[S]->C = 0;
	return 1;
}
int main()
{
	struct NODE* N1 = malloc(sizeof(struct NODE));
	struct NODE* N2 = malloc(sizeof(struct NODE));
	struct NODE* N3 = malloc(sizeof(struct NODE));
	struct NODE* N4 = malloc(sizeof(struct NODE));
	struct NODE* N5 = malloc(sizeof(struct NODE));

	N1->C = 2;
	N1->K = 1;
	N2->C = 2;
	N2->K = 2;
	N3->C = 2;
	N3->K = 3;
	N4->C = 2;
	N4->K = 4;
	N5->C = 2;
	N5->K = 5;

	struct NODE* NODES[] = {N1,N2,N3,N4,N5};
	int graph[N][N] =
		{{0,1,0,0,0},
		 {0,0,1,0,1},
		 {0,0,0,1,0},
		 {0,0,0,0,0},
		 {1,0,0,0,0}};
	printf("RIS: %d\n",DFV(0,graph,NODES));
	return 0;
}

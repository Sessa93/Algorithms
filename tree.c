#include <stdlib.h>
#include <stdio.h>

struct TREE_NODE
{
	struct TREE_NODE *P;
	struct TREE_NODE *L;
	struct TREE_NODE *R;
	int K;
};

void INSERT_RIGHT(struct TREE_NODE *N, struct TREE_NODE *K)
{
	struct TREE_NODE *S = N;
	while(S->R != NULL) S = S->R;
	S->R = K;
	K->P = S;
}

void INSERT_LEFT(struct TREE_NODE *N, struct TREE_NODE *K)
{
	struct TREE_NODE *S = N;
	while(S->L != NULL) S = S->L;
	S->L = K;
	K->P = S;
}

//N address of the TRUE root
struct TREE_NODE* SEARCH(struct TREE_NODE *N, int K)
{
	if(N->K == K) return N;
	if(N == NULL) return NULL;
	struct TREE_NODE *X = SEARCH(N->L,K);
	struct TREE_NODE *Y = SEARCH(N->R,K);
	if(X != NULL) return X;
	if(Y != NULL) return Y;
}

struct TREE_NODE* MAXIMUM(struct TREE_NODE *N)
{
	if(N == NULL) return NULL;
	if(N->L == NULL && N->R == NULL) return N;
	int M = N->K;
	struct TREE_NODE *X = MAXIMUM(N->L);
	struct TREE_NODE *Y = MAXIMUM(N->R);
	if(X != NULL)
	{
		if(X->K > M) return X;
	}
	if(Y != NULL)
	{
		if(Y->K > M) return Y;
	}
}

struct TREE_NODE* MINIMUM(struct TREE_NODE *N)
{
	if(N == NULL) return NULL;
	if(N->L == NULL && N->R == NULL) return N;
	int min = N->K;
	struct TREE_NODE *X = MINIMUM(N->L);
	struct TREE_NODE *Y = MINIMUM(N->R);
	if(X != NULL)
	{
		if(X->K < min) return X;
	}
	if(Y != NULL)
	{
		if(Y->K < min) return Y;
	}
}

void DELETE(struct TREE_NODE* N)
{
	struct TREE_NODE *P = N->P;
	struct TREE_NODE *L = N->L;
	struct TREE_NODE *R = N->R;
	if(P == NULL)
	{
		N->L = NULL;
		N->R = NULL;
	}
	else
	{
		if(R != NULL) P->R = R;
		//if(L != NULL)
	}
}

int WALK_2(struct TREE_NODE* N, int TOT)
{
	if(DOUBLE_WALK_2(N,TOT)>1) return 1;
	return 0;
}

int DOUBLE_WALK_2(struct TREE_NODE* N, int TOT)
{
	if(N->R == NULL && N->L == NULL)
	{
		if(N->K == TOT) return 1;
		return 0;
	}
	return DOUBLE_WALK_2(N->R,TOT-(N->K)) + DOUBLE_WALK_2(N->L, TOT-(N->K));

}

int WALK(struct TREE_NODE* N, int TOT)
{
	int tmp = 0;
	if(N->R == NULL && N->L == NULL)
	{
		if(N->K == TOT) return 1;
		else return 0;
	}
	if(N->R != NULL) tmp = WALK(N->R,TOT-(N->K));
	if(tmp) return 1;
	else
	{
		if(N->L != NULL) tmp = WALK(N->L, TOT-(N->K));
		if(tmp) return 1;
	} 
	return 0;
}

int DOUBLE_WALK(struct TREE_NODE* N, int TOT)
{
	int RR=0, RL=0;
	struct TREE_NODE* R = N->R;
	struct TREE_NODE* L = N->L;
	if(R != NULL) RR = WALK(R,TOT-(N->K));
	if(L != NULL) RL = WALK(L,TOT-(N->K));
	if(RR && RL) return 1;
	else
	{
		if(RR) DOUBLE_WALK(N->R,TOT-(N->K));
		if(RL) DOUBLE_WALK(N->L,TOT-(N->K));
	}
	return 0;
}

int main()
{
	struct TREE_NODE* ROOT = malloc(sizeof(struct TREE_NODE));
	struct TREE_NODE* N1 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N2 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N3 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N4 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N5 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N6 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N7 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N8 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N9 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N10 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N11 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N12 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N13 = malloc(sizeof(struct TREE_NODE));
        struct TREE_NODE* N14 = malloc(sizeof(struct TREE_NODE));
	
	ROOT->P = NULL;
	ROOT->K = 1;
	ROOT->L = N1;
	ROOT->R = N2;

	N1->P = ROOT;
	N1->K = 1;
	N1->L = N3;
	N1->R = N4;
	
	N2->P = ROOT;
	N2->K = 3;
	N2->L = N5;
	N2->R = N6;

	N3->P = N1;
	N3->K = 1;
	N3->L = N7;
	N3->R = N8;

	N4->P = N1;
	N4->K = 2;
	N4->L = N9;
	N4->R = N10;
	
	N5->P = N2;
	N5->K = 5;
	N5->L = N11;
	N5->R = N12;

	N6->P = N2;
	N6->K = 0;
	N6->L = N13;
	N6->R = N14;
	
	N7->P = N3;
	N7->K = 2;
	N7->L = NULL;
	N7->R = NULL;

	N8->P = N3;
	N8->K = 4;
	N8->L = NULL;
	N8->R = NULL;
	
	N9->P = N4;
	N9->K = 3;
	N9->L = NULL;
	N9->R = NULL;
	
	N10->P = N4;
	N10->K = 8;
	N10->L = NULL;
	N10->R = NULL;

	N11->P = N5;
	N11->K = 5;
	N11->L = NULL;
	N11->R = NULL;

	N12->P = N5;
	N12->K = 5;
	N12->L = NULL;
	N12->R = NULL;
 
	N13->P = N6;
	N13->K = 5;
	N13->L = NULL;
	N13->R = NULL;

	N14->P = N6;
	N14->K = 5;
	N14->L = NULL;
	N14->R = NULL;
	
	printf("RIS: %d\n",WALK_2(ROOT,5));
	return 0;
}

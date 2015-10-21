#include <stdio.h>
#include <stdlib.h>

struct DCLIST
{
	int value;
	struct DCLIST *prev;
	struct DCLIST *next;
};

void HEAD_INSERT(struct DCLIST *H, int v)
{
	struct DCLIST *new;
	new = malloc(sizeof(struct DCLIST));
	new->value = v;
	new->next = H->next;
	H->next = new;
	new->prev = H;
}

void TAIL_INSERT(struct DCLIST *H, int v)
{
	struct DCLIST *T = H;
	struct DCLIST *N = malloc(sizeof(struct DCLIST));
	while(T->next != NULL) T = T->next;
	T->next = N;
	N->prev = T;
	N->next = NULL;	
	N->value = v;
}

void DELETE(struct DCLIST *H, struct DCLIST *D)
{
	struct DCLIST *P = NULL;
	if(D->prev != NULL) P = D->prev;
	struct DCLIST *S = NULL;
	if(D->next != NULL) S = D->next;
	if(P != NULL && S != NULL)
	{
		P->next = S;
		S->prev = P;
	}
	else
	{
		if(P != NULL) H->next = S;
		else
		{
			if(S != NULL) P->next = NULL;
		}
	}
}

struct DCLIST* SEARCH_K(struct DCLIST *H, int k)
{
	struct DCLIST *T = H->next;
	while(T->value != k && T->next != NULL) T = T->next;
	if(T->value == k) return T;
	return NULL;
}

//Delete every occurance of v
int DELETE_K(struct DCLIST *H, int v)
{
	int del = 0;
	struct DCLIST *D = SEARCH_K(H,v);
	while(D != NULL)
	{
		DELETE(H,D);
		D = SEARCH_K(H,v);
		del++;
	}
	return del;
}

void DISPLAY(struct DCLIST *H)
{
	struct DCLIST *T;
	if(H->next != NULL) T = H->next;
	do
	{
		printf("%d\n",T->value);
		T = T->next;
	}
	while(T != NULL);
}

int main()
{	
	struct DCLIST *H;
	int v;
	H->next = NULL;
	H->value = 0;
	H->prev = NULL;
	do
	{
		printf("Inserisci elemento: ");
		scanf("%d",&v);
		TAIL_INSERT(H,v);
	}while(v != -1);
	DISPLAY(H);
	printf("Deleted %d's one's\n",DELETE_K(H,1));
	DISPLAY(H);
	return 0;
}	

#include <stdio.h>
#define BIT_SIZE 3
#define SIZE 8
#define IMP_LEN 5

typedef struct IMP
{
	int value[IMP_LEN];
	int mask;
	char mark;
}

void init(IMP *to_reset)
{
	int i,j;
	for(i = 0; i < SIZE; i++)
	{
		for(j = 0; j < IMP_LEN; j++) to_reset->value[j] = -1;
		to_reset->mask = 0;
		to_reset->mark = 0;		
	}
}

int ones(int value)
{
	int i;
	int ones = 0;
	for(i = 0; i < BIT_SIZE; i++)
	{
		if(value & 1) ones++;
		value = value >> 1;
	}
	return ones;
}

int get_n(IMP *ON[], IMP *DC[], IMP *RIS[], int n)
{
	int i,j=0;
	for(i = 0; i < SIZE; i++)
	{
		if(ones(ON[i]->value[0]) == n) RIS[j] = ON[i]->value[0];
		if(ones(DC[i]->value[0]) == n)
		{
			if(RIS[j] != DC[i]->value[0])
			{
				j++;
				RIS[j] = DC[i];
			}	
		}
		j++;
	}
}

int hamming(int n1, int n2)
{
	return ones(n1 ^ n2);
}

void first_pass(IMP *ON[], IMP *DC[], IMP *RIS[])
{
	int one = 0;
	int i,j,k=0;
	//IMP I1,I2;
	IMP F[SIZE], S[SIZE];
	for(one = 0; one < BIT_SIZE; one++)
	{
		get_n(ON,DC,F,one);
		get_n(ON,DC,S,one+1);
		for(i = 0; i < SIZE; i++)
		{
			for(j = 0; j < SIZE; j++)
			{
				if(i != j && F[i].mask == S[j].mask && hamming(F[i].value[0],S[j].value) == 1)
				{
					RIS[k]->value[0] = F[i].value[0];
					RIS[k]->value[1] = S[j].value[0];
					RIS[k]->mask = F[i].value[0] ^ S[j].value[0];
				}
			}
		}
	}
}

void visua(IMP *I[])
{
	int i,j;
	for(i = 0; i < SIZE; i++)
	{
		if(I[i]->value[0] != -1) printf("%d",I[i]->value[0]);
		for(j = 1; j < IMP_LEN; j++)
		{
			if(I[i]->value[j] != -1) printf(",%d", I[i]->value[j]);
		}
		printf(" ");
		printf("%d,%d ", I[i]->
	}
}


void simplify(IMP *ON[], IMP *DC[], IMP *RIS[])
{
	
}

int main()
{
	IMP *ON[SIZE];
	IMP *DC[SIZE];
	init(ON);
	init(DC);
	int d = 0, i = 0;
	while(i != -1 && i < SIZE)
	{
		printf("\nInserisci ONSET: ");
		scanf("%d",&d);
		if(d != -1) ON[i]->value[0] = d;
		i++;
	}
	i = 0;
	while(i != -1 && i < SIZE)
	{
		printf("\nInserisci DCSET: ");
		scanf("%d",&d);
		if(d != -1) DC[i]->value[0] = d;
		i++;
	}

}

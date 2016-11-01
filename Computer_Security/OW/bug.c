#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int i;
  unsigned short int h;
  i = atoi(argv[1]);
  if(i == 0) {
    printf("I == 0\n");
    return 0;
  }

  h = i;
  printf("%d\n",h );

  if(h == 0) {
    printf("Access Granted\n");
  }
  return 0;
}

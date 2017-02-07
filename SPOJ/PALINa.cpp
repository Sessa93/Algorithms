#include <iostream>
#include <cmath>
#include <stdio.h>
#include <stack>
#include <vector>
#include <string>
#include <inttypes.h>
#include <stdint.h>
using namespace std;

bool palin(uint64_t nn) {
  uint64_t n = nn;
  uint64_t rev = 0;
  while(n != 0) {
    rev = rev + (n % 10);
    n = n / 10;
    rev *= 10;
  }
  rev /= 10;
  return nn == rev;
}

uint64_t search(uint64_t l, uint64_t u, uint64_t p) {
  if(u-l <= 1) return p;
  if(palin((l+u)/2)){
    if((l+u)/2 < p){
      p = (l+u)/2;
    }
  }
  uint64_t p1 = search(l,(u+l)/2,p);
  if (palin(p1) && p1 < p) return p1;
  return search((u+l)/2,u,p);
}

int main() {
  int n;
  uint64_t N[100];
  cin >> n;
  for(int i = 0; i < n; i++){
    cin >> N[i];
  }
  for(int i = 0; i < n; i++) {
    printf("%" PRIu64 "\n", search(N[i],2*N[i],2*N[i]));
  }
}

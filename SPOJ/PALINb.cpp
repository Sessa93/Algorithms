#include <iostream>
#include <stdio.h>
#include <string.h>
using namespace std;

#define INT(c) (c-48)
#define CHR(i) (i+48)

int half_inc(char s[], int len){
  int mid = len/2;
  int i = mid-1;
  if(len % 2 != 0) i = mid;
  for(int j = i+1; j < len; j++) s[j] = CHR(0);
  while(INT(s[i])+1 == 10 && i >= 0) {
    s[i] = CHR(0);
    i--;
  }
  if(i < 0) {
    s[len+1] = 0;
    for(int i = 0; i<=len; i++) s[i] = CHR(0);
    s[0] = CHR(1);
    len++;
  }
  else s[i] = CHR(INT(s[i])+1);
  return len;
}
//1340 -> 1331 -> 1441
void palindromize(char *s, int len, bool flag){
  char cs[len];
  // 1234 -> 1221
  for(int i = 0; i < len/2; i++) {
    cs[i] = s[i];
    cs[len-1-i] = s[i];
  }
  if(len % 2 != 0) cs[len/2] = s[len/2];
  cs[len] = 0;
  int c = strcmp(cs,s);
  if(c > 0 || (c == 0 && flag)) {
    cout << cs << "\n";
    return;
  }
  else {
    int len2 = half_inc(cs,len);
    palindromize(cs,len2,true);
  }
}

int main() {
  char *S[50];
  int n;
  cin >> n;
  for(int i = 0; i < n; i++) {
    S[i] = (char*)malloc(1000000);
    cin >> S[i];
  }
  for(int i = 0; i < n; i++) {
    int len = strlen(S[i]);
    palindromize(S[i],len,false);
  }
  return 0;
}

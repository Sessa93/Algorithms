#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stack>
using namespace std;

#define INT(c) (c-48)
#define CHR(i) (i+48)
#define MAX(a,b) (a >= b ? a : b)
#define MIN(a,b) (a <= b ? a : b)
#define MOD(z) (10+z)

// Perfom the real sum between a1 and a2
stack<char> add(char a1[], char a2[], int l1, int l2) {
  int carry = 0,a;
  std::stack<char> res;

  if(l1 >= l2) {
    for(int i = l1-1; i >= 0; i--) {
      if(i-(l1-l2) >= 0) a = INT(a1[i])+INT(a2[i-(l1-l2)]) + carry;
      else a = INT(a1[i]) + carry;

      if(a < 10) {
        res.push(CHR(a));
        carry = 0;
      }
      else {
        res.push(CHR(a%10));
        carry = 1;
      }
    }
    if(carry) res.push(CHR(1));
    return res;
  }
  else return add(a2,a1,l2,l1);
}

// a1 > a2, calculating a1 - a2
stack<char> subtract(char a1[], char a2[], int l1, int l2) {
  int carry = 0,a = -1;
  std::stack<char> res;
  for(int i = l1-1; i-(l1-l2) >= 0; i--) {
    if(INT(a1[i]) < INT(a2[i-(l1-l2)])) {
      int k = i-1;
      a = 10 + INT(a1[i]);
      while(INT(a1[k]) == 0) {
        a1[k] = CHR(9);
        k--;
      }
      a1[k] = CHR(INT(a1[k]) - 1);
      res.push(CHR(a-INT(a2[i-(l1-l2)])));
    }
    else {
      res.push(CHR(INT(a1[i]) - INT(a2[i-(l1-l2)]) ) );
    }
  }
  for(int i = (l1-l2)-1; i >= 0; i--) res.push(a1[i]);
  return res;
}

// Displays the operands and results in case of addition
void display_subadd(char a1[], char a2[], char op) {
  int l1 = strlen(a1);
  int l2 = strlen(a2);
  if(l1 == l2) printf(" "); // S
  if(l1 <= l2) {
    for(int i = 0; i < l2-l1; i++) printf(" ");
    printf("%s\n",a1);
  }
  else {
    printf("%s\n",a1);
    for(int i = 0; i < l1-l2-1; i++) printf(" ");
  }
  printf("%c%s\n",op,a2);
  for(int i = 0; i < MAX(l1,l2)+1; i++) printf("-");
  printf("\n");

  std::stack<char> res = (op == '+' ? add(a1,a2,l1,l2) : subtract(a1,a2,l1,l2));

  //Align the result
  int m = (res.size() - (MAX(l1,l2)));
  if(l1 == l2) printf(" ");
  for(int i = 0; i < (m < 0 ? -m : m); i++) printf(" ");
  while(!res.empty()) {
    printf("%c",res.top());
    res.pop();
  }
  printf("\n");
}

int main() {
  char a1[500],a2[500];
  cin >> a1;
  cin >> a2;
  display_subadd(a1,a2,'+');
  return 0;
}

#include <iostream>
#include <cmath>
#include <stdio.h>
#include <stack>
#include <string>
using namespace std;

#define OPN 40
#define CLS 41

bool check_letter(char c) {
  if(c >= 97 && c <= 122) return true;
  return false;
}

bool check_operator(char c) {
  if(c != 40 && c != 41 && !check_letter(c)) return true;
  return false;
}

void convert_to_polish(char *s) {
  std::stack<char> stck, t_stck;
  int levels = 0,level=0;
  char op,c;
  bool copy = false;

  //Count the levels
  //(a+(b*c))
  for(int i = 0; s[i] != 0; i++)
    if(s[i] == OPN) levels++;

  for(int j = 0; s[j] != 0; j++) {
    if(s[j] == OPN) level++;
    if(s[j] == CLS) level--;
    if(level==1) copy = true;
    if(level < 1) copy = false;
    if(copy) {
      if(check_operator(s[j]) && level == 1) op = s[j];
      else stck.push(s[j]);
    }
    if(s[j] == OPN && 1 == level) stck.pop();
  }
  stck.push(op);

  for(int l = 2; l <= levels; l++){
    c = stck.top();
    while(c != CLS) {
      t_stck.push(c);
      stck.pop();
      c = stck.top();
    }
    stck.pop();
    c = stck.pop();
    while(!check_operator(c)) {
      
    }
  }

  while(!stck.empty()) {
    cout << stck.top() << "\n";
    stck.pop();
  }
}

int main() {
  char *s;
  cin >> s;
  convert_to_polish(s);
  return 0;
}

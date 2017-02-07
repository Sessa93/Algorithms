#include <iostream>
#include <cmath>
#include <stdio.h>
#include <stack>
#include <vector>
#include <string>
using namespace std;

#define OPN 40
#define CLS 41

// Example (a+(b*c)) ~ abc*+

bool check_letter(char c) {
  if(c >= 97 && c <= 122) return true;
  return false;
}

bool check_operator(char c) {
  if(c != 40 && c != 41 && !check_letter(c)) return true;
  return false;
}

int get_priority(char op) {
  switch (op) {
    case '+':
      return 0;
      break;
    case '-':
      return 1;
      break;
    case '*':
      return 2;
      break;
    case '/':
      return 3;
      break;
    case '^':
      return 4;
      break;
  }
  return -1;
}

// Shunting-Yard
void convert_to_polish(char *s) {
  std::stack<char> op_stck;
  std::vector<char> output;
  char op;

  for(int i = 0; s[i] != 0; i++) {
    if(check_letter(s[i])) output.push_back(s[i]);

    if(check_operator(s[i])) {
      if(op_stck.empty()) op_stck.push(s[i]);
      else {
        while(get_priority(s[i]) < get_priority(op_stck.top())) {
          output.push_back(op_stck.top());
          op_stck.pop();
        }
        op_stck.push(s[i]);
      }
    }

    if(s[i] == OPN) {
      op_stck.push(s[i]);
    }

    if(s[i] == CLS) {
      while(op_stck.top() != OPN) {
        output.push_back(op_stck.top());
        op_stck.pop();
        if(op_stck.empty()) {
          cout << "Error: non balanced parenthesis!";
          return;
        }
      }
      op_stck.pop();
    }
  }
  for(int i = 0; i < output.size(); i++) {
    cout << output[i];
  }
}

int main() {
  int n;
  char S[100][400];

  cin >> n;
  for(int i = 0; i < n; i++) {
    cin >> S[i];
  }
  for(int i = 0; i < n; i++) {
    convert_to_polish(S[i]);
    cout << "\n";
  }
  return 0;
}

#include <iostream>
#include <cmath>
#include <vector>
#include <stdio.h>
using namespace std;

// The idea is to just sieve the [l-u] segment
void segmented_sieve(int u, int l) {
  int sq = (int) std::sqrt(u);
  int segment_size = u-l+1;

  std::vector<bool> primes(segment_size);
  std::vector<bool> mark_small_primes(sq+1);
  std::vector<int> small_primes;

  //Initialization
  std::fill(mark_small_primes.begin(),mark_small_primes.end(),true);
  mark_small_primes[0] = false;
  mark_small_primes[1] = false;
  //Sieving up to sqrt(u)
  for(int i = 2; i <= sq; i++) {
    if(mark_small_primes[i]) {
      for(int j = i*i; j <= sq; j += i) {
        mark_small_primes[j] = false;
      }
    }
  }
  for(int i = 0; i <= sq; i++) {
    if(mark_small_primes[i] == true) {
      small_primes.push_back(i);
      if(i >= l && i <= u) cout << i << "\n";
    }
  }

  //memset(primes,true,sizeof(primes));
  std::fill(primes.begin(),primes.end(),true);
  // Iterate over the already found primes
  for(int i = 0; i < small_primes.size(); i++){
    int loLim = std::floor(l/small_primes[i]) * small_primes[i];
    if (loLim < l) loLim += small_primes[i];

    for (int j=loLim; j<=u; j+=small_primes[i]) {
      primes[j-l] = false;
    }
  }
  // True -> Prime!
  for (int i = l; i<=u; i++) {
    if (primes[i - l] == true && i != 1)
      cout << i << "\n";
  }
}

int main()
{
    int u,l;
    int n;
    int L[10],U[10];

    cin >> n;
    for (int i = 0; i < n; i++) {
      cin >> l >> u;
      L[i] = l;
      U[i] = u;
    }
    for(int i=0;i<n;i++){
      segmented_sieve(U[i],L[i]);
      cout << "\n";
    }
}

# Interview preparation kit, Recursion and Backtracking 

## [Davis' Staircase](https://www.hackerrank.com/challenges/ctci-recursive-staircase/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=recursion-backtracking)

* Thought: Each of the staircase, up to nth staircase can be expressed as `s[n] = s[n - 1] + s[n - 2] + s[n - 3]` since we can climb 1, 2 or 3 steps at once. Don't forget to add some basecases

* Analysis:
    * Time complexity: $$ O(N) $$, recursion with memoization, each node of the recursion tree will be generated once
    * Space complexity: $$ O(N) $$, recursion with memoization, same as above

```cpp
#include <bits/stdc++.h>
#define MAX_N 37
using namespace std;

// Complete the stepPerms function below.
int dp[MAX_N] = {0}; // cache
int stepPerms(int n) 
{
    if(n == 1)
    {
        dp[1] = 1;
        return 1;
    }
    else if(n == 2) // 1 1, 2
    {
        dp[2] = 2;
        return 2;
    }
    else if(n == 3) // 1 1 1, 1 2, 2 1, 3
    {
        dp[3] = 4;
        return 4;
    }
    else if(dp[n] != 0)
    {
        return dp[n];
    }
    dp[n] = stepPerms(n - 1) + stepPerms(n - 2) + stepPerms(n - 3);
    return dp[n];
}
```

## [Recursive Digit Sum](https://www.hackerrank.com/challenges/recursive-digit-sum/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=recursion-backtracking)

* Thought: Just directly implement as the problem statement, don't forget to pre-sum the string since the testcase such as 12345 repeated 99999999 times will cause TLE if we concatnate them together.
* Analysis: 
    * Time Complexity: log(N) where N is the magnitude of the number, i.e. itself. Since the magnitude is N, its length will be log(N) according to some high school math knowledge. For the next recursion it will be $$ log(log(N)) $$ ,so $$ T(n) = O(logN) + T(logN) $$
        example:
        123 * 999 presum 6 * 999
        5994 --> 27
        27 --> 9
        ends
        ```
    * Space Complexity: $$ O(N) $$ for storing the given number in an array

```python

import math
import os
import random
import re
import sys

# Complete the superDigit function below.
def superDigit(n, k):
    pre_sum = 0
    
    for digit in str(n): # cut down the redundancy
        pre_sum += int(digit)

    pre_sum *= k # sum first to avoid TLE, ex 12345 repeated 999999999 times, the string will be extremely long    

    return recursive_solve(pre_sum)

def recursive_solve(splitted):
    if len(str(splitted)) == 1:
        return int(splitted)
    
    tmp_sum = 0
    for digit in str(splitted):
        tmp_sum += int(digit)
    
    return recursive_solve(tmp_sum)

```



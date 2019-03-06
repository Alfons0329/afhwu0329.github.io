# Interview preparation kit, Dynamic Programming

## [Max Array Sum](https://www.hackerrank.com/challenges/max-array-sum/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dynamic-programming)

* Thought: Each of the dp[i] represent the maximum array sum in arr[0:1] (start side and end side are both included), consider each of the element in array, there will be 2 possibilities
    * (1) If we include this element, then the maximum subset [0:i] sum will be arr[i - 2] + arr[i] due to denial of adjacent numbers in subset.
    * (2) If we do not want such element, then the maximum subset [0:i] sum will be arr[i - 1], i.e. querying the closest answer.
* Note: It is usually hard to directly come up with a DP transformation function, rather it will be easier to come up with a recursive / search solution first. Sometimes, padding is needed, do not forget!
* Analysis: Time complexity O(N), Space complexity O(N) for the DP array
```cpp
int maxSubsetSum(vector<int> arr) 
{
    int res, n = arr.size();
    vector<int>dp(n + 2, 0); // for padding
    
    // starting from 0
    for(int i = 2; i < n + 2; i++)
    {
        dp[i] = max(dp[i - 2] + arr[i - 2 /*shift padding*/], dp[i - 1]);
    }

    return dp.back();
}

```
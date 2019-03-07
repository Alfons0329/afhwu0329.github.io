# Interview preparation kit, Dynamic Programming

## [Max Array Sum](https://www.hackerrank.com/challenges/max-array-sum/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dynamic-programming)

* Thought: Each of the dp[i] represent the maximum array sum in arr[0:1] (start side and end side are both included), consider each of the element in array, there will be 2 possibilities, hence the subproblem for DP
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

## [Candies](https://www.hackerrank.com/challenges/candies/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dynamic-programming)

* Thought: through the following steps 
    * (1) We can simply see that, the amount of candies each student receives depends on the amount of neighbor's candies, hence the subproblem for DP
        * Collecting the statistical data of "how many CONTINUOUS LOWER ELEMENT" on either the left or right side?
    * (2) Iterate the whole array, the minimum candies that this student requires is max(left_continuous_lower[i], right_continuous_lower[i]) + 1(at least one candy for each student)
        * Think the mountain as an example: 
        ```
            Score               1 2 3 4 3 2 1
            Left cnt lower      0 1 2 3 0 0 0
            Right cnt lower     0 0 0 3 2 1 0
        ```
        * Explanation: for student 3(0 base), he should get 3 (+ 1) cadies as minimum since there is 3 continuous less element on the left side and so is right, assigning 1 to the leftmost and rightmost element, we will get the optimum solution being: 1 2 3 4 3 2 1
* Analysis: Time complexity O(N), Space complexity O(N) for the DP array
```cpp
long candies(int n, vector<int> arr) 
{
    int m = arr.size();
    vector<ull> left_cont_less_cnt(m, 0);
    vector<ull> right_cont_less_cnt(m, 0);

    // init, step (1)
    for(int i = 0; i < m - 1; i++)
    {
        if(arr[i] < arr[i + 1])
        {
            left_cont_less_cnt[i + 1] = left_cont_less_cnt[i] + 1;
        }
    }

    for(int i = m - 1; i >= 1; i--)
    {
        if(arr[i - 1] > arr[i])
        {
            right_cont_less_cnt[i - 1] = right_cont_less_cnt[i] + 1;
        }
    }

    // dp process, step (2)
    ull res = 0;

    for(int i = 0; i < m; i++)
    {
        res += max(left_cont_less_cnt[i], right_cont_less_cnt[i]) + 1;
    }
    return res;

}

```
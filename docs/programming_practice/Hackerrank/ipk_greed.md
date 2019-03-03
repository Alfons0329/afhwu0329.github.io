# Interview preparation kit, Greedy Algorithm

## [Minimum absolute difference in array](https://www.hackerrank.com/challenges/minimum-absolute-difference-in-an-array/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=greedy-algorithms)
* Thought: `No need to brute force`, since it emphasizes on the abs diff b/w two numbers, then we can easily sort the whole array, and the diff b/w two consecutive elements will be the minimum.
```cpp
int minimumAbsoluteDifference(vector<int> arr) 
{
    int res = INT_MAX, n = arr.size();
    sort(arr.begin(), arr.end()); 
    for(int i = 0; i < n - 1; i++)
    {
        res = min(res, abs(arr[i + 1] - arr[i]));
        if(res == 0) // zero will be the smallest possible value, just return the answer immediately
        {
            return res;
        }
    }
    return res;
}

```
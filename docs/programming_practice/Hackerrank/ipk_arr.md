# Interview Preparation Kit, Array

## [Left rotation](https://www.hackerrank.com/challenges/ctci-array-left-rotation/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays)

* Thought: Rotate as intuition, but note that if `index - rot_cnt (which is d)` then the position should be `size - (rot_cnt - index)`
* Analysis: Time complexityL O(N), Space complexity: O(N)
```cpp
// Complete the rotLeft function below.
vector<int> rotLeft(vector<int> a, int d) 
{
    int n = a.size();
    vector<int>res(n, 0);
    
    for(int i = 0; i < n; i++)
    {
        if(i - d < 0)
        {
            res[n + (i - d)] = a[i];
        }
        else
        {
            res[(i - d) % n] = a[i];
        }
    }
    return res;
}
```
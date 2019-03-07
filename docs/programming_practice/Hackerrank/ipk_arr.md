# Interview Preparation Kit, Array

## [Left rotation](https://www.hackerrank.com/challenges/ctci-array-left-rotation/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays)

* Thought: Rotate as intuition, but note that if `index - rot_cnt (which is d)` then the position should be `size - (rot_cnt - index)`
* Analysis: 
    * Time complexityL O(N)
    * Space complexity: O(N)
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

## [Subset I](https://leetcode.com/problems/subsets/)

* Thought: There are up to 2^N possibilities, brute force will definitely failed. Since it counts up to 2^N
* Analysis: 
    * Time complexity O(N * 2 ^ N), where N is the cardinality of set, we check all 2 ^ N possibles and use bit manipulation (right shift up to length N in binary represenation). 
    * Space complexity: O(2 ^ N), store all the possible subsets.

```cpp
class Solution 
{
    public:
    vector<vector<int>> subsets(vector<int>& nums) 
    {
        int n = nums.size();
        int m = 1 << n, cnt = 0, i = 0;
        vector<vector <int> > res(0, vector<int>());
        vector<int> tmp;
        while(--m)
        {
            cnt = 0;
            i = m;
            while(i > 0)
            {
                if(i & 1)
                {
                    tmp.push_back(nums[nums.size() - cnt - 1]);
                }
                cnt++;
                i >>= 1; //shift right to check the next occurance
            }
            res.push_back(tmp);
            tmp.clear();
        }
        tmp.clear();
        res.push_back(tmp);//including the empty one
        return res;
    }
};
```
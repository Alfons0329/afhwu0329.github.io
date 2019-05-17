# Interview Preparation Kit, Array

## [Left rotation](https://www.hackerrank.com/challenges/ctci-array-left-rotation/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays)

* Thought: Rotate as intuition, but note that if `index - rot_cnt (which is d)` then the position should be `size - (rot_cnt - index)`
* Analysis: 
    * Time complexity: O(N)
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

## [Minimum Swaps 2](https://www.hackerrank.com/challenges/minimum-swaps-2/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays)
* Thought: Draw the circular relation b/w the numbers according to [this page](https://www.geeksforgeeks.org/minimum-number-swaps-required-sort-array/)

* Analysis: 
    * Time complexity: O(NlogN)
    * Space complexity: O(N)
```cpp
// Complete the minimumSwaps function below.
int dfs_circle(const vector<int>& arr_padded, int cur_pos, int arrow_cnt, int start_num, vector<bool>& visited)
{
    visited[cur_pos] = true;// mark current node as traversed
    // printf("DFS to %d\n", arr_padded[cur_pos]);
    
    cur_pos = arr_padded[cur_pos]; // move to the next one
    if(visited[cur_pos] == false)
    {
        arrow_cnt = dfs_circle(arr_padded, cur_pos, arrow_cnt + 1, start_num, visited); // keep dfs-ing
    }
    return arrow_cnt;

}
int minimumSwaps(vector<int> arr) 
{
    int n = arr.size(), res = 0;
    vector<int> arr_padded(arr.begin(), arr.end());
    arr_padded.insert(arr_padded.begin(), INT_MAX);

    vector<bool> visited(n + 1, false);
    bool finished_all = true;
    for(int i = 1; i < n + 1;)
    {
        if(arr_padded[i] == i) // already in the right position, no need for dfs, to avoid stackoverflow
        {
            i++;
            continue;
        }
        else
        {
            finished_all = true;
            for(int j = 1; j < n + 1; j++)
            {
                if(visited[j] == false)
                {
                    i = j;
                    finished_all = false;
                    break;
                }
            }

            if(finished_all == false)
            {
                res += dfs_circle(arr_padded, i, 0, arr_padded[i], visited);
            }
        }
        if(finished_all)
        {
            break;
        }
    }
    printf("final res %d\n", res);
    return res;

}
```
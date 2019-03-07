# Interview preparation kit, Searching

## [Ice Cream Parlor](https://www.hackerrank.com/challenges/ctci-ice-cream-parlor/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=search)

* Thought: This problem is similar to [this video](https://www.youtube.com/watch?v=XKu_SEDAykw&t=923s), which serves as an example of google's interview.
the only difference is we print the position of matched pairs, like pos_i and pos_j with criteria cost[pos_i] + cost[pos_j] equals to K
There is no need for brute force in O(N^2), or binary search in O(NlogN), only need a map to store the occurances of each price.
* Analysis: 
    * Time complexity: O(N), iterating the whole string and implement the statistical data
    * Space complexity: O(N), by using a map data to store the statistical data.

```cpp
void whatFlavors(vector<int> cost, int money) 
{
    // init
    unordered_map<int, cost_data> mymap; // for statistical purpose of cost and its occurance
    int n = cost.size();
    for(int i = 0; i < n ; i++)
    {
        mymap[cost[i]].pos = i + 1;
        mymap[cost[i]].cnt++;
    }

    // iterate map process
    int cost_1 = 0, cost_2 = 0;
    for(int i = 0; i < n ; i++)
    {
        cost_1 = cost[i];
        cost_2 = money - cost_1;
        if(cost_2 == cost_1) // should be exisiting exactly 2, ex : 2 + 2 = 4 for unique solution
        {
            if(mymap[cost_1].cnt == 2) 
            {
                printf("%d %d\n", i + 1, mymap[cost_1].pos); // 1-base
                return;
            }
        }
        else
        {
            if(mymap[cost_2].cnt == 1) //exists for the other cost
            {
                printf("%d %d\n", i + 1, mymap[cost_2].pos);  // 1-base
                return;
            }
        }
    }
}

```

## [Pairs](https://www.hackerrank.com/challenges/pairs/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=search)
* Thought: Similar to the first problem in this page, use map to check the occurance will be fine, solve in linear time and there is no need for brute force solution 
* Analysis: 
    * Time complexity: O(N), iterating the whole string and implement the statistical data
    * Space complexity: O(N), by using a map data to store the statistical data.

```cpp
int pairs(int k, vector<int> arr) 
{
    int res = 0, n = arr.size();
    unordered_map<int, int> mymap;
    for(int i = 0; i < n; i++)
    {
        mymap[arr[i]]++;
    }

    for(int i = 0 ; i < n; i++)
    {
        if(mymap[arr[i] - k] == 1) // all the elements are unique, directly check if occurance exists 1
        {
            res++;
        }
    }
    return res;
}
```
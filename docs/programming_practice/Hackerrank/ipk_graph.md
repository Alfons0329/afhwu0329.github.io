# Interview preparation kit, Graph

## [Find the Nearest Clone](https://www.hackerrank.com/challenges/find-the-nearest-clone/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=graphs)

* Thought: Run through the following steps
    * (1) Make adjacent list
    * (2) Traverse nodes, mark the current nodes as traversed to prevent stack overflow, if encounter the node of the same color, update the result and set res = 0 for next searching
    * (3) Keep DFS until all the node has been traversed and all the function has been returned
* Analysis: 
    * Time complexity: O(V + E), typical graph dfs traversal
    * Space complexity: O(V + E), storing the edge and node data

```cpp
#include <bits/stdc++.h>

using namespace std;

vector<string> split_string(string);

// Complete the findShortest function below.

/*
 * For the unweighted graph, <name>:
 *
 * 1. The number of nodes is <name>_nodes.
 * 2. The number of edges is <name>_edges.
 * 3. An edge exists between <name>_from[i] to <name>_to[i].
 *
 */


void dfs(vector<vector <int> > edges, vector<bool> visited, vector<long> ids, int cur_id, int& res, int cur_len, int val)
{
    visited[cur_id] = true;// mark current node as traversed

    // if the color of current node is what we want, update the result, but NO NEED TO RETURN 
    // since there will be other path not visited, go to the other path will be suitable.

    int n = edges[cur_id].size();// how many mnodes are "being connected" by current node?
    if(ids[cur_id - 1] == val && cur_len > 0)
    {
        res = min(res, cur_len);
        cur_len = 0;
        // restart from current node

        for(int i = 0; i < n; i++)
        {
            if(!visited[edges[cur_id][i]]) // if untraversed
            {
                dfs(edges, visited, ids, edges[cur_id][i], res, cur_len + 1, val);
            }
        }
    }
    else
    {
        // keep searching
        for(int i = 0; i < n; i++)
        {
            if(!visited[edges[cur_id][i]]) // if untraversed
            {
                dfs(edges, visited, ids, edges[cur_id][i], res, cur_len + 1, val);
            }
        }    
    }
}

int findShortest(int graph_nodes, vector<int> graph_from, vector<int> graph_to, vector<long> ids, int val) 
{
    // init 
    int res = INT_MAX;
    int m = graph_from.size(); // edge size
    int n = ids.size(); // node size 
    vector<vector<int>> edges(n + 1, vector<int>()); // edge relations of node_1 -> node_2 -> node_3, n + 1 for padding one base
    unordered_map<int, int> color_cnt;
    vector<bool> visited(n + 1, false);

    // make adjacent list
    for(int i = 0; i < m; i++)
    {
        edges[graph_from[i]].push_back(graph_to[i]); // make the edge relations
        edges[graph_to[i]].push_back(graph_from[i]); // make the edge relations
    }

    // find the starting node of that color
    int start_id = -1;
    for(int i = 0 ; i < n; i++)
    {
        color_cnt[ids[i]]++;
        if(ids[i] == val)
        {
            start_id = i + 1;
        }
    }

    // starting dfs
    if(color_cnt[start_id] == 1 || start_id == -1) //only one for that color, return -1 directly or no such color
    {
        return -1;
    }
    dfs(edges, visited, ids, start_id, res, 0, val);
    printf("res %d \n", res == INT_MAX ? -1 : res);
    return res == INT_MAX ? -1 : res;
}


```
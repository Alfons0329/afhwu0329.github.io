# Tree problems

## [94. Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/description/)

* Thought: By using the non-trivial solution(non-recursive)
, we may descend to the left subtree and collecting them, once we reach the null node(i.e. end of the tree, we break immediately(dont push)), pop out the node on the top of the stack and push the value to the result array, then go the the right subtree.
(The rest of explanation will be in the comment part of code)
* Analysis: Time complexity O(N), Space complexity O(N)
* Graphical explanation: ![](https://i.imgur.com/z0QX6jH.jpg)
```cpp
class Solution
{
public:
    vector<int> res;
    vector<int> inorderTraversal(TreeNode* root)
    {
        stack<TreeNode*> stk;
        if(root)
        {
            stk.push(root);
            TreeNode* cur = root;
            while(stk.size() || cur != NULL)
            {
                //equivalent to inorder(cur->left);
                while(cur != NULL)
                {
                    cur = cur->left;
                    if(cur == NULL)
                    {
                        break;
                    }
                    stk.push(cur);
                }
                //equivalent to res.push_back(cur->val);
                cur = stk.top();
                //reassign
                stk.pop();
                res.push_back(cur->val);
                //equivalent to inorder(cur->right);
                cur = cur->right;
                if(cur != NULL)
                {
                    stk.push(cur);
                }
            }
        }
        return res;
    }

};
```

## [104. Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/)

* Thought: Use `DFS` to descend down the left and right subtree respectively. Each descend(either left or right) increase the depth level by one. The result is very clear to understand since we may just collect the depth of left and right subtree and update
```cpp
int l_depth = dfs_depth(root->left, cur_depth + 1);
int r_depth = dfs_depth(root->right, cur_depth + 1);
```
, return the max depth of them. Later, recursive the structure again until the recursion calling stack has been done.
* Analysis: Time complexity O(N), Space complexity O(N)

```cpp
class Solution
{
public:
    int max_depth = 0;
    int maxDepth(TreeNode* root)
    {
        return dfs_depth(root, 0);
    }
    int dfs_depth(TreeNode* root, int cur_depth)
    {
        if(root == NULL)
        {
            return cur_depth;
        }
        int l_depth = dfs_depth(root->left, cur_depth + 1);
        int r_depth = dfs_depth(root->right, cur_depth + 1);
        max_depth = max(l_depth, r_depth);
        return max_depth;
    }
};

```

## [110. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree/)


* Thought: Descend down the tree, retrieve the depth of left and right subtree, if 
	* (1)reach the null node, just return depth - 1 to represend the depth of its parent.
	* (2)normal, return after the l_depth and r_depth have been retrieved, return the max depth comparing l_depth and r_depth representing the depth of such subtree(root will retrieve the depth of left subtree and right subtree and return the max value b/w two.)
* Visualization of Calling Stack ![](https://i.imgur.com/pvhNSI6.jpg)
* Analysis: Time complexity O(N), Space complexity O(N)

```cpp
class Solution
{
public:
    bool is_bal;
    bool isBalanced(TreeNode* root)
    {
        is_bal = 1;
        dfs_subtree(root, 0);
        return is_bal;
    }
    int dfs_subtree(TreeNode* root, int depth)
    {
        if(root == NULL)
        {
            return depth - 1;
        }
        int l_depth = dfs_subtree(root->left, depth + 1);
        int r_depth = dfs_subtree(root->right, depth + 1);
        if(abs(l_depth - r_depth) > 1)
        {
            is_bal = 0;
        }
        int max_depth = max(left_depth, right_depth);
        return max_depth; //dont forget plus one for ascend one level to root
    }
};
```

## [112. Path Sum](https://leetcode.com/problems/path-sum/)

* Thought(WA, in the comment part of code)
```cpp
class Solution 
{
public:
    bool hasPathSum(TreeNode* root, int sum) 
    {
        if(root == NULL) // if reaching the leaf and at the same time sum has been decreased to 0, answer is right.
        {
            return sum == 0; 
        }
        return hasPathSum(root -> left, sum - root->val) | hasPathSum(root -> right, sum - root -> val); // descend for the left subtree and right subtree
    }
};
```
* Fault: If the testcase is [1, 2] 1, then it will fail since the 1(root) -> left_null, such incomplete path will return true due to the recursive call in  `hasPathSum(root -> right, sum - root -> val)` and `if(root == NULL) { return sum == 0; }` owing to 1 - 1 == 0 and reach null
* Revision: STOP when traverse to `leaf node` rather than `null node`

```cpp
class Solution 
{
public:
    bool hasPathSum(TreeNode* root, int sum) 
    {
        if(root == NULL) //directly return false if it is an empty tree
        {
            return false; 
        }
        if(root != NULL && root ->left == NULL && root -> right == NULL) //stop at the leaf node to check if the residue of sum equals to the value of leaf node.
        {
            return root -> val == sum;
        }
        return hasPathSum(root -> left, sum - root->val) || hasPathSum(root -> right, sum - root -> val); //descending to check if left or right path gives at least one path for the creterium.
    }
};
```
* Analysis: Time complexity O(N), Space complexity O(N)

## [113. Path Sum II](https://leetcode.com/problems/path-sum-ii/)
* 
## 236. LCA
## 863. All Nodes Distance K in Binary Tree

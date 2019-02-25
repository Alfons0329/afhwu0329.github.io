# Tree problems

## 94. [Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/description/)
* Thought: By using the non-trivial solution(non-recursive)
, we may descend to the left subtree and collecting them, once we reach the null node(i.e. end of the tree, we break immediately(dont push)), pop out the node on the top of the stack and push the value to the result array, then go the the right subtree.
(The rest of explanation will be in the comment part of code)
* Analysis: Time complexity O(N), Space complexity O(N)
* Graphical explanation: ![](https://i.imgur.com/z0QX6jH.jpg)
### iterative solution
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
* Thought: Use `DFS` to descend down the left and right subtree respectively. Each descend increase the depth level by one. The result is very clear since we may just collect the depth of left and right subtree and update
```cpp
int l_depth = dfs_depth(root->left, cur_depth + 1);
int r_depth = dfs_depth(root->right, cur_depth + 1);
```
, return the max depth of them. Later, recursive the structure again until the recursion calling stack has been done.
* Analysis: Time complexity O(N), Space complexity O(N)
```cpp
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
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
## 110. Balanced Binary Tree
## 112. Path Sum
## 113. Path Sum II
## 236. LCA
## 863. All Nodes Distance K in Binary Tree

# Tree problems part 2

## [236. LCA](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/)

* Thought: 
  * (1) Store the information of the `parent node` of each node. 
  * (2) Ascend the node if the node is deeper in order to get closer to the common parent, finally the lowest common ancestor will match . It is quite intuitive. You may imagine by drawing a picture.
  * The rest of the explanations are written in the comment part of the code
* Analysis: Time complexity O(N), Space complexity O(N)

```cpp
class Solution
{
public:
    struct node_info
    {
        TreeNode* parent;
        int depth;
    };
    map<TreeNode*, node_info> node_info_map;
    TreeNode* res;
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* node_p, TreeNode* node_q)
    {
        dfs_information(root, 0);
        node_info_map[root].parent = root; // for the root itself, preventing runtime error
        res = root; // initialize
        climbup_LCA(node_p, node_q); // solve
        return res;
    }

    // step1, traverse the tree first to find the child-parent pair
    void dfs_information(TreeNode* root, int depth)
    {
        if(root == NULL)
        {
            return;
        }
        node_info_map[root].depth = depth;
        if(root->left) // Store the child-parent information for left child node if it is a non-null one
        {
            node_info_map[root->left].parent = root;
            dfs_information(root->left, depth + 1);
        }
        if(root->right) // Store the child-parent information for right child node if it is a non-null one
        {
            node_info_map[root->right].parent = root;
            dfs_information(root->right, depth + 1);
        }
    }

    // step2, climb up to find the LCA, using depth comparison algorithm
    void climbup_LCA(TreeNode* node_p, TreeNode* node_q)
    {
        if(node_info_map[node_p].parent == node_info_map[node_q].parent)
        {
            res = node_info_map[node_p].parent;
            return;
        }
        else if(node_info_map[node_p].parent == node_q)
        {
            res = node_q;
            return;
        }
        else if(node_info_map[node_q].parent == node_p)
        {
            res = node_p;
            return;
        }

		// the deeper node has to climb up one depth
        else if(node_info_map[node_p].depth > node_info_map[node_q].depth) 
        {
            climbup_LCA(node_info_map[node_p].parent, node_q);
        }
        else
        {
            climbup_LCA(node_p, node_info_map[node_q].parent);
        }
    }
};

```

## [863. All Nodes Distance K in Binary Tree](https://leetcode.com/problems/all-nodes-distance-k-in-binary-tree/)

* Thought: 
  * (1) Store the information of the `parent node` of each node.
  * (2) Starting from the target node, traverse the parent node, left child, right child. `Remember to mark the node visited, consequently it will prevent child -> parent and parent -> child, two times back and forth resulting in an 0 distance just owing to 2 - 1(child -> parent) - 1(parent -> child), but it is not the case of answer.`
* Analysis: Time complexity O(N), Space complexity O(N)

```cpp
// 12ms
class Solution 
{
public:
    unordered_map<TreeNode*, TreeNode*> parent_map;
    vector<int> res;
    vector<int> distanceK(TreeNode* root, TreeNode* target, int K) 
    {
        dfs_parent(root);
        dist(target, K);
        return res;
    }
    void dfs_parent(TreeNode* root)
    {
        
        if(root -> left) // store the child-parent information for the left child node 
        {
            parent_map[root -> left] = root;
            dfs_parent(root -> left);
        }
        
        if(root -> right) // store the child-parent information for the right child node 
        {
            parent_map[root -> right] = root;
            dfs_parent(root -> right);
        }
    }
    void dist(TreeNode* target, int K)
    {
        if(target -> val < 0)// do not push_back too much redundant node
        {
            return;
        }
        
        if(K == 0)
        {
            res.push_back(target -> val);
            return; //exit immediately to prevent stackoverflow
        }
        
        target -> val = -1; // mark as done 
        
        if(parent_map.count(target)) // check for parent
        {
            dist(parent_map[target], K - 1);
        }
        
        if(target -> left)
        {
            dist(target -> left, K - 1);
        }
        
        if(target -> right)
        {
            dist(target -> right, K - 1);
        }
        
    }
};

```

# Interview preparation kit, Tree

## [LCA](https://www.hackerrank.com/challenges/binary-search-tree-lowest-common-ancestor/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=trees)

* Please refer [here](https://alfons0329.github.io/afhwu0329.github.io/programming_practice/leetcode_OJ_Single/tree2/#236-lca) for LCA.

## [Is this a BST?](https://www.hackerrank.com/challenges/ctci-is-binary-search-tree/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=trees)

* Thought: Given the property of BST, where `root's value > max of left subtree but < min of right shubtree`. So we descend down the whole tree and check the property recursively. For more information, please check the comment part of the code.
* Analysis: 
    * Time complexity: O(N), where N is the nodes of given tree.
    * Spacee complexity: O(N), where N is the nodes of given tree. or O(1) if the tree itself does not taken into account.
```cpp
bool checkBST(Node* root) 
{
    if(root == NULL)
    {
       return true; 
    }
    
    int lsub_max = 0, rsub_min = INT_MAX;
    sub_treemax(root -> left, lsub_max);
    sub_treemin(root -> right, rsub_min);

    if(root -> data <= lsub_max) // violates the property
    {
        return false;
    }
    
    if(root -> data >= rsub_min) // violates the property
    {
        return false;
    }
    
    return checkBST(root -> left) && checkBST(root -> right) ; // descend and recursively checking the whole tree
    
}

void sub_treemax(Node* root, int& sub_max)
{
    if(root == NULL)
    {
        return;
    }
    
    sub_max = max(root -> data, sub_max);
    sub_treemax(root -> left, sub_max);
    sub_treemax(root -> right, sub_max);
}

void sub_treemin(Node* root, int& sub_min)
{
    if(root == NULL)
    {
        return;
    }
    
    sub_min = min(root -> data, sub_min);
    // printf("data %d, submin update to %d\n", root -> data, sub_min);
    sub_treemin(root -> left, sub_min);
    sub_treemin(root -> right, sub_min);
}
```
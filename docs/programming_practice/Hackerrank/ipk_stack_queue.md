# Interview preparation kit, Stack and Queue 

## [Tale of Stacks](https://www.hackerrank.com/challenges/ctci-queue-using-two-stacks/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=stacks-queues) Using stack to implement queue

* Thought: Push into the stack causing the first in the bottom, so pop-push again to the other stack solves the problem. 
Visualization below
```
        bottom<->top         bottom<->top
        
oper        stk_new_ontop       stk_output
push 1      1
push 2      1 2
push 3      1 2 3
pop,rev need                ->  3 2 1
front                           3 2 [1]
pop                             3 2
pop                             3
pop
push 4     4    
push 5     4 5
push 6     4 5 6
front,rev need              ->  6 5 [4]                              
```
* Analysis: 
    * Time complexity: push O(1), pop O(N) worst, O(1) if output stack still exists, front same as pop
    * Space complexity: O(N) the new aux - stack is needed. 
```cpp
class MyQueue {

    public:
        stack<int> stack_newest_on_top, stack_output;
        void push(int x) 
        {
            stack_newest_on_top.push(x);
        }

        void pop() 
        {
            reverse_clone_stack();
            stack_output.pop();
        }

        int front() 
        {
            reverse_clone_stack();
            return stack_output.top();
        }

        void reverse_clone_stack()
        {

            if(stack_newest_on_top.size() == 0 || stack_output.size() != 0) // no need to process newly pushed stack or the original one can stlil be used
            {
                return;
            }

            // push element into output stack only if nothing from it can be output, process batch by batch
            while(stack_newest_on_top.size() != 0)
            {
                stack_output.push(stack_newest_on_top.top());
                stack_newest_on_top.pop();    
            }
        }

};
```

## [Balanced Parenthesis](https://www.hackerrank.com/challenges/balanced-brackets/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=stacks-queues)

* Thought: Use stack to trace the balance property, if `(, [, {` is encountered, push, for right parenthesis, see the following situation
    * If the stack is already empty, then unbalanced ex: (())) last ) will meet an empty stack
    * If the stack top is not the paired set, ex: ()= with ], then unbalanced
    * Otherwise keep iterating through the string
    * After the string has been iterated, if the stack is NON-EMPTY, rethrn NO either such as (((), too many left parenthesis causing the stack still remains non-empty
* Analysis: 
    * Time complexity: O(N), simply iterate through the string. 
    * Space complexity: O(N) the helper stack is needed. 

```cpp
string isBalanced(string s) 
{
    stack<char> stk;
    int n = s.size();
    for(int i = 0; i < n; i++)
    {
        if(s[i] == '(' || s[i] == '{' ||s[i] == '[' )
        {
            stk.push(s[i]);
        }
        else if(s[i] == ')')
        {
            if(stk.empty())
            {
                return "NO";
            }
            if(stk.top() == '(')
            {
                stk.pop();
            }
            else
            {
                return "NO";
            }
        }
        else if(s[i] == '}')
        {
            if(stk.empty())
            {
                return "NO";
            }
            if(stk.top() == '{')
            {
                stk.pop();
            } 
            else
            {
                return "NO";
            }
        }
        else if(s[i] == ']')
        {
            if(stk.empty())
            {
                return "NO";
            }
            if(stk.top() == '[')
            {
                stk.pop();
            } 
            else
            {
                return "NO";
            }
        }

        
    }

    if(stk.empty() != true)
    {
        return "NO";
    }
    return "YES";
}

```

## [Largest Rectangle]()

* Thought: Check the maximum width of each element, that is stretch as long as it can, once the lower building is encountered, break.
* Analysis:
    * Time complexity: O(N^2)
    * Space complexity: O(N) if count the given vector from problem in memory usage, O(1) if not, only some helper variables.

```cpp
long largestRectangle(vector<int> h) 
{
    long n = h.size();
    long res = 0;
    for(long i = 0; i < n; i++)
    {
        long l_ptr = i - 1, r_ptr = i + 1;
        long base = h[i];
        while(l_ptr >= 0)
        {
            if(h[l_ptr] < base)
            {
                break;
            }
            l_ptr--;
        }
        
        while(r_ptr < n)
        {
            if(h[r_ptr] < base)
            {
                break;
            }
            r_ptr++;
        }
        res = max(res, base * (r_ptr - l_ptr - 1));
    }
    printf("res %ld\n", res);
    return res;
}

```
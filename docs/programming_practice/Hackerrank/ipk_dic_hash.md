# interview preparation kit, Dictionaries and Hashmaps

## [Sherlok and Anagrams](https://www.hackerrank.com/challenges/sherlock-and-anagrams/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps) 

* Thought 1(TLE): Brute force to find all the possible substring pair of length from 1 to n where n is the given string length. 
* Analysis: Time complexity: O(N^4), Space complexity: O(N), although it seems to be a nested loop and calls the function `check_anagram` n times, the time complexity is actually N. Since in `function call` the memory will be allocated in stack, after the call ends, it will be released (may think of recursion stack overflow to understand this), each allocate in stack is up to length N of the string, and being released later, thus won't grow up to N^2   
```cpp
// Complete the sherlockAndAnagrams function below. ie how many pairs of substring anagrams??
bool check_anagram(string s1, string s2)
{
    unordered_map<char, int> mp1;

    int n = s1.size();

    for(int i = 0; i < n; i++) // stat data for string 1
    {
        mp1[s1[i]]++;
    }

    for(int i = 0; i < n; i++) // use data from string 2 to decrease the frequency of characters, if all are zero, then anagrams are matched.
    {
        mp1[s2[i]]--;
    }
    for(unordered_map<char, int>::iterator it = mp1.begin(); it != mp1.end(); it++)
    {
        if(it -> second > 0)
        {
            return false;
        }
    }
    return true;
}

int sherlockAndAnagrams(string s) 
{
    int n = s.size(), res = 0;
    string s1, s2;
    unordered_map<char, int> fmap;
    
    for(int i = 0; i < n; i++) // calculate len = 1 first and use n * (n - 1) / 2 to save time
    {
        fmap[s[i]]++;
    }

    for(unordered_map<char, int>::iterator it = fmap.begin(); it != fmap.end(); it++)
    {
        res += it -> second * (it -> second  - 1) / 2;
    }

    for(int i = 2; i <= n; i++) // brute force finding the substring pairds starting from len 1 to len size - 1 
    {
        for(int j = 0; j < n; j++)
        {
            if(j + i - 1 >= n)
            {
                break;
            }
            else
            {
                s1 = s.substr(j, i); // master string
                for(int k = j + 1; k + i - 1 < n; k++)
                {
                    s2 = s.substr(k, i);
                    if(check(s1, s2))
                    {
                        res++;
                    }
                }
            }
        }
    }
    printf("res %d\n", res);
    return res;
}
```
* Fault: The idea is too brute force, N^4 does take lots of time.
* Thought 2(AC, optimized from thought 1): When we got some substrings that forms a group for anagram, such as [abc, cba, bac]. We don't actually need to select each by each to count the occurances. Due to the same group of anagram, 2 of them makes a pair, by using the `combinatoric method`, such that C(num_of_elements, 2) is the answer. More detailed explanations are written in the comment section of the following code.

* Analysis: Time complexity: O(N^3 log N), Space complexity O(N^2) due to storing the combinations of substrings in one main string. 
 
```cpp
int sherlockAndAnagrams(string s) 
{
    int sz = s.size(), res = 0;
    string s1;
    unordered_map<char, int> map_1;
    unordered_map<string, int> map_2;

    for(int i = 0; i < sz; i++) // calculate len = 1 first and use n * (n - 1) / 2 to save time
    {
        map_1[s[i]]++;
    }

    for(unordered_map<char, int>::iterator it = map_1.begin(); it != map_1.end(); it++)
    {
        res += it -> second * (it -> second  - 1) / 2;
    }

    for(int i = 2; i <= sz; i++)
    {
        for(int j = 0; j < sz; j++)
        {
            if(j + i - 1 >= sz)
            {
                break;
            }
            else
            {
                s1 = s.substr(j, i); // master string
                sort(s1.begin(), s1.end());
                map_2[s1]++;
            }
        }
    }
    
    for(unordered_map<string, int>::iterator it = map_2.begin(); it != map_2.end(); it++)
    {
        res += it -> second * (it -> second  - 1) / 2;
    }

    printf("res %d\n", res);
    return res;
}

```

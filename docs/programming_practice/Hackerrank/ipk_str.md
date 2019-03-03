# Interview preparation kit, String Manipulation

## [Sherlok and Valid Srings](https://www.hackerrank.com/challenges/sherlock-and-valid-string/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings)

* Thought: Run through the following steps
    * (1) Collecting the statistic data of occurance of all the characters in the given string
    * (2) Iterate through the map in (1), and count the `occurance of occurance` 
    * (3) In (1), (2) such as aaabbccc is a : 3, b : 2, c : 3, and the `occurance of occurance` is 3 : 2 and 2 : 1
    * (4) Considering the situations
        * (4-1) If there are > 2 kinds of occurances, such as aaabbccc, than we must at least 1 a and 1 c, which is not satisfiable  
        * (4-2) If only one kind of occurances, such as abcdefg, than already satisfiable
        * The following has only 2 kinds of occurances.
        * (4-3) If the occurance of lower frequency alphabet is only one, then we just easily remove that, such as aaab a^100b, removing one b satisfies the criterium.
        * (4-4) If the higher frequency lower one is only 1 and that occurance of higher frequency is exactly 1, such as bbbcc, removing one b satisfies the criterium. But aaabbbcc is 3 : 2, 2 : 1, should at least remove one a and b, does not satisfies the criterium.
        * (4-5) No matter the occurance of occurance, if higher frequency - lower frequency exceeds 1, then it fails, such as bbbbbbcc (bbbbbbc has been filtered in 4-3)
        * (4-6) The rest failed

* Analysis: Time complexity: O(N), iterating the whole string and implement the statistical data, Space complexity: O(N), by using a map data to store the statistical data.

```cpp
string isValid(string s) 
{
    // step (1)
    unordered_map<char, int> map_1; // stat data for character occurance
    string res;
    int n = s.size();

    for(int i = 0; i < n; i++)
    {
        map_1[s[i]]++;
    }

    // step (2), (3)

    map<int, int> freq_cnt; // order matters
    for(unordered_map<char, int>::iterator it = map_1.begin() ;it != map_1.end(); it++)
    {
        freq_cnt[it -> second]++;
    }
    if(freq_cnt.size() > 2) // step 4-1
    {
        return "NO";
    } 
    else if(freq_cnt.size() == 1) // all the same frequency, ex aabbccddee, we only have 2 : 5 // step 4-2
    {
        return "YES";
    }

    map<int, int>::iterator it = freq_cnt.begin();
    int f1 = it -> first;
    int lower_freq_cnt = it -> second; 

    map<int, int>::iterator it2 = ++it;
    int f2 = it2 -> first;
    int higher_freq_cnt = it2 -> second;
    
    int lower_freq = min(f1, f2), higher_freq = max(f1, f2);

    if(lower_freq == 1 && lower_freq_cnt == 1) // step 4-3
    {
        return "YES";
    }
    else if(higher_freq - lower_freq == 1 && higher_freq_cnt == 1) // step 4-4
    {
        return "YES";
    }
    else if(higher_freq - lower_freq > 1) // step 4-5 
    {
        return "NO";
    }
    
    return "NO"; // step 4-6
}
```
/*
 * @Description: 
 * @Version: 
 * @Author: Tyrion Huu
 * @Date: 2022-11-30 21:14:23
 * @LastEditors: Tyrion Huu
 * @LastEditTime: 2022-12-01 13:21:40
 */
#include <iostream>
#include <string>

int LongestDuplicateCharacter(char * string, int N)
{
    int max = 0;
    int count = 1;
    char last = string[0];
    for (int i = 1; i < N; i++) //N - I > 0
    {
        if (string[i] == last)
        {
            count++;
        }
        else
        {
            count = 1;
        }
        
        if (count > max)        //COUNT - MAX > 0
        {
            max = count;
        }
        last = string[i];
    }
    // while(N > 0)
    // {
    //     if (string[N] == last)
    //     {
    //         count++;
    //     }
    //     else
    //     {
    //         if (count > max)
    //         {
    //             max = count;
    //         }
    //         count = 0;
    //     }
    //     last = string[N];
    //     N--;
    // }
    return max;
}
# Lab03 Longest-Duplicated-Substring

## Category

[toc]

## Task & Purpose

Substring is a consecutive sequence of characters occurrences at least once in a string. Duplicate substring is a kind of substring that consists of the same character. For example, the duplicate substring of "aabbbc" is “aa”, “bbb” and “c”. Given a string *S* and its length *N*, can you figure out the length of its longest duplicate substring?

Note that *N* (**1<=N<=100**) will be stored in **x3100**, and each character of *S* is stored in successive memory locations starting with address **x3101**. You may assume that *S* only contains a-z and A-Z.

Your job: store the output, longest duplicate substring in **x3050**.
 R0-R7 are set to zeroes at the beginning, and your program should start at **x3000**. 

## Example

Here are several examples:

| Memory Address | x3050      | …    | x3101   | x3101 | x3102 | x3103 | x3104 | x3105 | x3106 |
| -------------- | ---------- | ---- | ------- | ----- | ----- | ----- | ----- | ----- | ----- |
| Example 1      | RESULT = 3 |      | NUM = 6 | a     | a     | b     | b     | b     | c     |
| Example 2      | RESULT = 4 |      | NUM = 5 | Z     | Z     | Z     | Z     | z     |       |
| Example 3      | RESULT = 3 |      | NUM = 6 | a     | a     | b     | a     | a     | a     |


## Requirements

Note that in this experiment, you are required to use **assembly code**. Here are some notifications:

- Your program should start with **.ORIG x3000**;
- Your program should end with **.END**;
- Your last instruction should be **TRAP x25 (HALT)** 
- Write comments when necessary. 

## Principle

1. First of all, initialize max to 0, count to 1, and last(last character) to string[0], which is the first character(a integer actually);
2. Set i to 1, which will be used as a counter for the loop; And begin the loop;
   1. Increment the current address of the character;
   2. If the current character is identical as the last one, increment count; Else, set count to 1;
   3. See if count is larger than max, if so, set max to count;
   4. Set last to the current character. 
3. Once the loop is exited, return max. 

## Procedure

1. At first, I write a concise C++ program, which could help me a lot have a clear thread of how to write a assembly program;
2. Originally, I tried to use a subroutine. However, I found that I don't have enough registers to do that, owing to the extra two registers that are needed for stack pointer and return linkage, so, I just write all in one routine;
3. Once I have the overall skeleton, it's relatively easy to write the assembly program, and I had not encountered many worth-mentioning bugs so far. 

## Code in C++

In this specific problem, I found it massively helpful to right the program first with my most skilled programming language - C++, and I evenly found it much more useful than draw a flowchart which requires me to use another software and to spend much more time. 

```c++
int LongestDuplicateCharacter(char * string, int N)
{
    int max = 0;
    int count = 1;
    char last = string[0];
    for (int i = 1; i < N; i++) //N - I > 0
    {
        if (string[i] == last)
            count++;
        else
            count = 1;
        if (count > max)        //COUNT - MAX > 0
            max = count;
        last = string[i];
    }
    return max;
}
```

## Code

```assembly
.ORIG X3000
        LDI     R0, NUM         ;R0 = THE CURRENT LENGTH OF THE STRING   
        LD      R1, DATA        ;R1 IS THE CURRENT ADDRESS OF THE STRING

        ;INITIALIZE THE REGISTERS
        AND     R2, R2, #0      ;IS THE COUNTER
        ADD     R2, R2, #1      ;COUNTER = 1
        AND     R3, R3, #0      ;STORES THE RESULT, AKA MAX
        AND     R4, R4, #0      ;STORES THE CURRENT VALUE OF THE CHARACTER
        AND     R5, R5, #0      ;STORES THE LAST VALUE OF THE CHARACTER
        LDR     R5, R1, #0      ;LOAD THE LAST VALUE OF CHARACTER INTO R5，char last = string[0]
        AND     R6, R6, #0
        ADD     R6, R6, #1      ;I = 1

        ;LOOP BEGIN
        LOOP1   NOT     R7, R6
                ADD     R7, R7, #1      ;R7 = -I
                ADD     R7, R7, R0      ;R7 = N - I

                TEST1   BRNZ    DONE1           ;TEST IF I > N, TEST R7

                        ADD     R1, R1, #1      ;R1 = R1 + 1, AKA INCREMENT THE ADDRESS
                        LDR     R4, R1, #0      ;LOAD THE CURRENT VALUE OF THE CHARACTER INTO R4, string[i]

                        NOT     R7, R4
                        ADD     R7, R7, #1      ;R7 = -R4
                        ADD     R7, R7, R5      ;R7 = R5 - R4, 

                TEST2   BRNP    ELSE1           ;TEST IF R5 = R4, if (string[i] == last)

                        ADD     R2, R2, #1      ;R2 = R2 + 1， count++;
                        BRNZP   TEST3

                ELSE1   AND     R2, R2, #0      ;R2 = 0, count = 0;
                        ADD     R2, R2, #1      ;COUNTER = 1

                TEST3   NOT     R7, R3
                        ADD     R7, R7, #1      ;R7 = -R3
                        ADD     R7, R7, R2      ;R7 = R2 - R3

                        BRNZ    THEN            ;TEST IF R2 > R3, if (count > max)//COUNT - MAX > 0
                        ADD     R3, R2, #0      ;R3 = R2, max = count;

                THEN    ADD     R5, R4, #0      ;R5 = R4, AKA THE LAST CHARACTER IS NOW THE CURRENT CHARACTER
                        ADD     R6, R6, #1      ;I = I + 1
                        BRNZP   LOOP1
        
        DONE1   ADD     R2, R3, #0      ;R2 = R3, AKA THE LENGTH OF THE LONGEST REPEATING CHARACTER IS NOW IN R2  
                STI     R2, RESULT
                HALT

        ;STORING THE STRING IN THE MEMORY
        RESULT  .FILL   X3050
        NUM     .FILL   X3100
        DATA    .FILL   X3101 
.END
```

## Result

First off, all the given instances are tested and satisfied. 

For instance, when I input 6, a, a, a, a, a, b, the number stored in x3150 is 5. 


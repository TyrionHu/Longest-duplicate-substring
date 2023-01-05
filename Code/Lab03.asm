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

                        BRNZ    THEN            ;TEST IF R2 > R3, if (count > max)        //COUNT - MAX > 0
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
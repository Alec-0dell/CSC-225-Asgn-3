.ORIG x3000
    LD R0, STRING_HEAD
    ST R0 STRING_PTR
    AND R1, R1, #0
    AND R1, R2, #0
    LEA R0, PROMPT_KEY
    PUTS
    GETC
    OUT
    ADD R2, R0, #-16
    ADD R2, R2, #-16
    ADD R2, R2, #-16
    GETC
    OUT
    ADD R1, R0, #-10
    BRnp ERROR
    LEA R0, PROMPT_STRING
    PUTS

GET_USER_STRING:
    GETC
    OUT
    ADD R1, R0, #-10
    BRz ECHO_USER_INPUT
    JSR STORE_USER_STRING
    BR GET_USER_STRING
    
STORE_USER_STRING:
    LD R1, STRING_PTR
    ADD R0, R2, R0
    LD R3, LOWER_CHAR_BOUND
    NOT R3, R3
    ADD R3, R3, #-1
    LD R4, UPPER_CHAR_BOUND
    NOT R4, R4
    ADD R4, R4, #-1
    ADD R3, R0, R3
    BRzp #1
    LD R0, UNKWN_STRING
    ADD R4, R0, R4
    BRnz #1
    LD R0, UNKWN_STRING
    STI R0, STRING_PTR
    ADD R1, R1, #1
    ST R1, STRING_PTR
    RET
    
ECHO_USER_INPUT:
    AND R0, R0, #0
    STI R0, STRING_PTR
    ADD R1, R1, #1
    ST R1, STRING_PTR
    LEA R0, FINAL_STRING
    PUTS
    LD R0, STRING_HEAD
    PUTS
    HALT
    
ERROR:
    LEA R0, ERROR_STRING
    PUTS
    HALT
    
PROMPT_STRING .STRINGZ "Unencrypted string: "
PROMPT_KEY  .STRINGZ "Encryption key (0-9): "
FINAL_STRING  .STRINGZ "Encrypted string: "
ERROR_STRING  .STRINGZ "ERR PLEASE ENTER AN INTEGER (0-9) THEN PRESS ENTER"
LOWER_CHAR_BOUND .FILL x20
UPPER_CHAR_BOUND .FILL  x7E
UNKWN_STRING .FILL x3F
STRING_PTR  .FILL x30C0
STRING_HEAD .FILL x30C0

.END
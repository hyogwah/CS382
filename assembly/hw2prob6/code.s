


caller:
    SUB     SP, SP, 8
    STUR    X30, [SP, 0]
    MOV     X0, 2
    MOV     X1, 3
    BL      addition
    LDUR    X30, [SP, 0]
    ADD     SP, SP, 8   
    BR      X30

addition:
    ADD     X0, X0, X1 // X0 = a + b
    BR      X30        

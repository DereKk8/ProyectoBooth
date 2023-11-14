START:
    MOV ACC, CTE
    0x04               # Cargar 4
    INV ACC
    MOV A, ACC
    MOV ACC, CTE
    0x01
    ADD ACC, A       
    MOV A, ACC      # -4 al registro A

    MOV ACC, CTE 
    i               # Cargar el iterador i
    MOV DPTR, ACC
    MOV ACC, [DTPR]
    ADD ACC, A      # Realizar la operacion (i - 4)
    
    JN              # Comparar SI i < 4 
    BOOTH
    JMP CTE
    ENDLOOP

BOOTH:
    JMP CTE
    ACTUALIZAR_Q0

ACTUALIZAR_Q0:
    MOV ACC, CTE
    Q                
    MOV DTPR, ACC
    MOV ACC, [DTPR]
    MOV A, ACC        # Cargar Q a A

    MOV ACC, CTE
    0x01                 
    AND ACC, A        # Relizar la operacion AND para extraer el bit mas significativo de Q -- Q0
    MOV A, ACC

    MOV ACC, CTE      #      
    Q0                #  
    MOV DTPR, ACC     #  
    MOV ACC, A 
    MOV [DTPR], ACC   # Guardar en Q0 el resultado de Q&1   

    JMP CTE
    EVALUAR_IGUALDAD

EVALUAR_IGUALDAD:
    INV ACC
    MOV A, ACC
    MOV ACC, CTE
    0x01
    ADD ACC, A        # -Q0 a A
    MOV A, ACC      

    MOV ACC, CTE
    Q_              # Cargar (Q_-1) a ACC
    MOV DTPR, ACC
    MOV ACC, [DTPR]
    ADD ACC, A      # Operar ((Q_-1) - Q0)

    JZ 
    ACTUALIZAR_Q1
    
    JMP CTE 
    EVALUAR_DIFERENCIA


SHIFT:
    MOV ACC, CTE
    a                
    MOV DTPR, ACC
    MOV ACC, [DTPR]
    MOV A, ACC
    MOV ACC, CTE
    0X01

    AND ACC, A     # Operacion and entre a y 1 para extrer el bit menos siginificativo de a                 
    MOV A, ACC

    MOV ACC, CTE
    0X01 
    ADD ACC, A    # operacion entre el; bit menos significativo de a y 1 para evluar si el BMS es 1 o 0 

    INV ACC
    MOV A, ACC
    MOV ACC, CTE
    0x01
    ADD ACC, A

    JZ
    corrimientoARQ
    JMP CTE
    corrimientoQ

corrimientoARQ:
    RSH ACC, CTE
    Q
    MOV A, ACC

    MOV ACC, CTE
    0X08           # operacion con 1000
    ADD ACC, A
    MOV A, ACC

    MOV ACC, CTE
    Q
    MOV DTPR, ACC
    MOV [DTPR], A  # gaurdar el corrimeinto aritemtico de Q
    
    MOV ACC, CTE
    a
    MOV DTPR, ACC
    MOV ACC, [DTPR]  # cargar el valor de A
    MOV A, ACC

    MOV ACC, CTE
    0X08           # operacion con 1000 para extraer el bit mas significativo
    ADD ACC, A
    MOV A, ACC

    MOV ACC CTE
    MSB
    MOV DTPR, ACC
    MOV ACC, A
    MOV [DTPR], ACC  # GUARDAR EL BIT MAS SIGNIFICATIVO DE A 

    MOV ACC, CTE
    0X08
    INV ACC
    MOV A, ACC       # -1000
    MOV ACC, CTE
    0x01
    ADD ACC, A
    MOV A, ACC

    MOV ACC, CTE
    MSB 
    MOV DTPR, ACC
    MOV ACC, [DTPR]
    ADD ACC, A       # OPERAR EL BIT MAS SIGNFICIATIVO DE A CON -1000

    JZ
    correrA1
    JMP CTE
    correrA

correrA1:
    RSH ACC, CTE
    a 
    MOV A, ACC

    MOV ACC, CTE
    0X08
    ADD ACC, A       # realizar el corrimiento aritmetico de A
    MOV A, ACC

    MOV ACC, CTE
    a 
    MOV DTPR, ACC
    MOV ACC, A
    MOV [DTPR], ACC  # actualziar el valor de A

correrA:
    RSH ACC, CTE
    a 
    MOV A, ACC

    MOV ACC, CTE
    a 
    MOV DTPR, ACC
    MOV ACC, A
    MOV [DTPR], ACC  # actualziar el valor de A 
    

corrimientoQ:
    RSH ACC, CTE 
    Q
    MOV A, ACC

    MOV ACC, CTE
    Q
    MOV DTPR, ACC
    MOV [DTPR], A  # gaurdar el corrimeinto aritemtico de Q


ACTUALIZAR_Q:
    MOV ACC, CTE            
    Q                  
    MOV DTPR, ACC      
    MOV ACC, A 
    MOV [DTPR], ACC   # Guardar en Q el resultado del corrimiento 


    JMP CTE
    ACTUALIZAR_Q0

    JMP CTE
    ITERACION


ACTUALIZAR_Q1:
    MOV ACC, CTE
    Q                
    MOV DTPR, ACC
    MOV ACC, [DTPR]
    MOV A, ACC        # Cargar Q a A

    MOV ACC, CTE
    0x01                 
    AND ACC, A        # Relizar la operacion AND para extraer el bit mas significativo de Q antes del corrimiento
    MOV A, ACC

    MOV ACC, CTE      #      
    Q1                #  
    MOV DTPR, ACC     #  
    MOV ACC, A 
    MOV [DTPR], ACC   # Guardar en Q1 el resultado de Q&1   

    JMP CTE
    SHIFT

EVALUAR_DIFERENCIA:

    MOV ACC, CTE
    Q_
    MOV DTPR, ACC
    MOV ACC, [DTPR]
    INV ACC
    MOV A, ACC
    MOV ACC, CTE
    0x01
    ADD ACC, A
    MOV A, ACC         # -(Q_-1) AL REGISTRO A

    MOV ACC, CTE
    Q0
    MOV DTPR, ACC
    MOV ACC, [DTPR]

    ADD ACC, A        # Operar (Q0 - (Q_-1)) evaluar si Q0 < Q1  (0, 1)

    JN
    SUMAR_AM
    JMP CTE
    RESTAR_AM

SUMAR_AM:
    MOV ACC, CTE
    a
    MOV DTPR, ACC
    MOV ACC, [DTPR]
    MOV A, ACC

    MOV ACC, CTE
    M
    MOV DTPR, ACC
    MOV ACC, [DTPR]

    ADD ACC, A        # Realizar la operacion A + M
    MOV A, ACC

    JMP CTE
    ACTUALIZAR_A

RESTAR_AM:
    MOV ACC, CTE
    M
    MOV DTPR, ACC
    MOV ACC, [DTPR]
    INV ACC
    MOV A, ACC
    MOV ACC, CTE
    0x01
    ADD ACC, A            
    MOV A, ACC

    MOV ACC, CTE
    a
    MOV DTPR, ACC
    MOV ACC, [DTPR]

    ADD ACC, A        # Realizar la operacion A - M
    MOV A, ACC

    JMP CTE
    ACTUALIZAR_A

ITERACION:
    MOV ACC, CTE
    i
    MOV DTPR, ACC 
    MOV ACC, [DTPR]
    MOV A, ACC

    MOV ACC, CTE
    0x01
    ADD ACC, A  
    MOV [DTPR], ACC   # Guardar en i el resultado de i + 1

    JMP CTE
    START

ACTUALIZAR_A:
    MOV ACC, CTE            
    a                  
    MOV DTPR, ACC      
    MOV ACC, A 
    MOV [DTPR], ACC   # Guardar en A la operacion entre A y M

    JMP CTE 
    ITERACION

ENDLOOP:


i: 0x08
Q: 0x09
M: 0x10
Q_: 0x11
Q0: 0x12
A: 0x13
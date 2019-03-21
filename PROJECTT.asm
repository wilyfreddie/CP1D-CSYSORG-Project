;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/// CSYSORG/LBYCP1D
;/// CAPA-CARTA-GARAN-HIZON
;/// BARRIER TOLL SYSTEM
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
#INCLUDE<P18F4550.INC>

    CONFIG FOSC	    = INTOSCIO_EC	;Frequency of the Oscillator
    CONFIG CPUDIV   = OSC1_PLL2
    CONFIG PLLDIV   = 1			;PLL Division
    CONFIG PWRT	    = OFF		;Power-up Timer
    CONFIG BOR	    = OFF		;Programmable Brown-out Reset
    CONFIG WDT	    = OFF		;Watchdog Timer
    CONFIG MCLRE    = ON		;Master Clear Reset
    CONFIG STVREN   = ON		;StackFull/Underflow Reset
    CONFIG LVP	    = OFF		;Single-Supply Enable Bit
    CONFIG ICPRT    = OFF		;In-Circuit Debug/Programming Port
    CONFIG XINST    = OFF		;Extended Instruction Set Enable bit
    CONFIG DEBUG    = OFF
    CONFIG FCMEN    = OFF		;Fail-Safe Clock Monitor Enabler
    CONFIG IESO	    = OFF		;Internal/External Oscillator Switchover bit
    CONFIG LPT1OSC  = OFF		;Low-Power Timer1 Oscillator Enabler
    CONFIG CCP2MX   = ON		;CCP2 MUX
    CONFIG PBADEN   = OFF		;PORTB A/D Enable bit
    CONFIG USBDIV   = 2			;USB Clock Selection
    CONFIG VREGE N  = OFF		;USB Internal Voltage Regulator Enable
 
    ;-------------VARIABLE DECLARION-------------
    ;//LCD
    LCD_CTRL	EQU PORTD  ; LCD CONTROL ON PORTC
    LCD_DATA	EQU PORTB  ; LCD DATA TRANSMITION ON PORTD
    RS		EQU RD0   
    EN		EQU RD1
    
    ;--------------------------------------------
    
ORG 0x00 
    BANKSEL OSCCON
    MOVLW   B'00001010'
    MOVWF   OSCCON
    CLRF    TRISB ; Configuration of PORT B as output (Data pins LCD)
    CLRF    TRISD ; Configuration of PORT D as output (RD0-R/S, RD1-E)
 
    MOVLW   B'00000111'
 
    CLRF    PORTB ; Setting PORTB to "0000000"
    CLRF    PORTD ; Setting PORTD to "0000000"
 
INIT
    CALL    InitiateLCD
 
MAIN
    CALL    PRINTCHAR
    CALL    DELAY_5ms
    CALL    PRINTCHAR2
    CALL    DELAY_5ms
    GOTO    MAIN
 
InitiateLCD 
    BCF	    LCD_CTRL,RS ; Setting RS as 0 (Sends commands to LCD)
    CALL    DELAY_5ms
 
    MOVLW   B'00000001' ; Clearing display H'1'
    MOVWF   LCD_DATA 
    CALL    ENABLE
    ;CALL    DELAY_5ms

    MOVLW   B'00111000' ; Funtion set H'38'
    MOVWF   LCD_DATA 
    CALL    ENABLE
    ;CALL    DELAY_5ms

    MOVLW   B'00001111' ; Display on off	H'0F'
    MOVWF   LCD_DATA
    CALL    ENABLE
   ;CALL    DELAY_5ms

    MOVLW   B'00000110' ; Entry mod set	H'06'
    MOVWF   LCD_DATA
    CALL    ENABLE
    ;CALL    DELAY_5ms 
    
    MOVLW   H'0C' ; Display on, Cursor Off
    MOVWF   LCD_DATA
    CALL    ENABLE
    ;CALL    DELAY_5ms 
    
    MOVLW   H'3C' ; ACTIVATE SECOND LINE
    MOVWF   LCD_DATA
    CALL    ENABLE
    ;CALL    DELAY_5ms 
    
 
 RETURN
 
PRINTCHAR 
    CALL LCD_ClearScreen

    MOVLW 'H' ; Print character "H"
    CALL LCD_Write   
    MOVLW 'e' ; Print character "e"
    CALL LCD_Write
    MOVLW 'l' ; Print character "l"
    CALL LCD_Write
    MOVLW 'l' ; Print character "l"
    CALL LCD_Write
    MOVLW 'o' ; Print character "o"
    CALL LCD_Write
    
    MOVLW d'32' ; Print caracter " "
    CALL LCD_Write

    MOVLW 'D' ; Print caracter "W"
    CALL LCD_Write
    MOVLW 'a' ; Print character "o"
    CALL LCD_Write
    MOVLW 'n' ; Print character "r"
    CALL LCD_Write   
    MOVLW 'i' ; Print character "l"
    CALL LCD_Write   
    MOVLW 'e' ; Print character "d"
    CALL LCD_Write    
    MOVLW 'l' ; Print character "d"
    CALL LCD_Write
    MOVLW '!'
    CALL LCD_Write
    
    CALL LCD_NewLine
   
    MOVLW '-'
    CALL LCD_Write
    MOVLW 'I'
    CALL LCD_Write
    MOVLW 'v'
    CALL LCD_Write
    MOVLW 'a'
    CALL LCD_Write
    MOVLW 'n'
    CALL LCD_Write
   
    RETURN

PRINTCHAR2
    CALL LCD_ClearScreen
    MOVLW 'H'
    CALL LCD_Write
    MOVLW 'i'
    CALL LCD_Write
    MOVLW ' '
    CALL LCD_Write
    MOVLW 'm'
    CALL LCD_Write
    MOVLW 'y'
    CALL LCD_Write
    MOVLW ' '
    CALL LCD_Write
    MOVLW 'l'
    CALL LCD_Write
    MOVLW 'o'
    CALL LCD_Write
    MOVLW 'v'
    CALL LCD_Write
    MOVLW 'e'
    CALL LCD_Write
    MOVLW 's'
    CALL LCD_Write
    MOVLW ','
    CALL LCD_Write
    
    CALL LCD_NewLine
    
    MOVLW 'T'
    CALL LCD_Write
    MOVLW 'A'
    CALL LCD_Write
    MOVLW 'M'
    CALL LCD_Write
    MOVLW 'M'
    CALL LCD_Write
    MOVLW 'Y'
    CALL LCD_Write
    MOVLW ' '
    CALL LCD_Write
    MOVLW '&'
    CALL LCD_Write
    MOVLW ' '
    CALL LCD_Write
    MOVLW 'D'
    CALL LCD_Write
    MOVLW 'A'
    CALL LCD_Write
    MOVLW 'N'
    CALL LCD_Write
    MOVLW 'E'
    CALL LCD_Write
    RETURN
    
LCD_Write
    BSF	    LCD_CTRL,RS
    MOVWF   LCD_DATA
    CALL    ENABLE
    RETURN
    
LCD_NewLine
    BCF	    LCD_CTRL,RS
    MOVLW   H'C0' ; Force to Second Row Position 1
    MOVWF   LCD_DATA
    CALL    ENABLE
    RETURN
    
LCD_ClearScreen
    BCF	    LCD_CTRL,RS
    MOVLW   H'01' ; Clearing display H'1'
    MOVWF   LCD_DATA 
    CALL    ENABLE
    
    MOVLW   b'00000010' ; Set cursor home
    MOVWF   LCD_DATA 
    CALL    ENABLE
    RETURN
    
ENABLE 
    BSF	    LCD_CTRL,EN ; E pin is high, (LCD is processing the incoming data)
    NOP
    BCF	    LCD_CTRL,EN ; E pin is low, (LCD does not care what is happening)
    RETURN
 
DELAY_5ms 
    MOVLW   .5 ; Delay of 5 ms
    MOVWF   TMR0
 
LOOP 
    BTFSS   INTCON,2
    GOTO    LOOP
    BCF	    INTCON,2
    RETURN
 
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

END
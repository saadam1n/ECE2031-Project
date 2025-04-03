; Brightness_Control_Demo.asm
; Test Demo Code for Modifying BRightness
; Connor Smith
; ECE 2031 Final Project
; Created 04/3/2025

LOADI   0       
STORE   BRIGHTNESS 
LOADI   0         
STORE   LED_INDEX  

LOOP:   
	LOADI   10         ; maybe needs to be 9? no nvm
	SUB     LED_INDEX  ; 10 - LED_INDEX 
	JZERO   END        ; If result is 0, exit loop

	LOAD    LED_INDEX  ; Load LED Index again (since AC was overwritten)
	ADDI    NewLEDs    ; Compute LED address (NewLEDs + LED_INDEX)
	STORE   TEMP_ADDR  ; Store computed address in TEMP_ADDR

	LOAD    BRIGHTNESS ; Load Brightness Value
	OUT 	TEMP_ADDR  ; actual peripheral part

	LOAD    BRIGHTNESS ; Reload Brightness Value
	ADDI    10         ; Increment Brightness
	STORE   BRIGHTNESS ; Store updated Brightness

	LOAD    LED_INDEX  ; Reload LED Index
	ADDI    1          ; Increment LED Index
	STORE   LED_INDEX  ; Store updated LED Index

	JUMP    LOOP

END:	JUMP    END	   ; Infinite loop


BRIGHTNESS:   DW  0   
LED_INDEX:    DW  0   
TEMP_ADDR:    DW  0   ; Temp storage

Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
NewLEDs:   EQU &H020  ; Base address for LEDs (0x20)
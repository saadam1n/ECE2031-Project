; An empty ASM program ...

ORG 0
	LOADI 1023
	OUT NewLEDs
	JUMP 0
	
; IO address constants
Switches:  EQU 000
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
NewLEDs:   EQU &H020

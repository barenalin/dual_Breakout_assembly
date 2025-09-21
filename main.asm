include Irvine32.inc
EXTERN final@0:PROC
EXTERN final1@0:PROC
.data
state BYTE 0
boolvalue BYTE 0
gm BYTE 0
InfoCursor CONSOLE_CURSOR_INFO <1,0>
consoleHandle DWORD ?
cellsWritten DWORD ?
bytesWritten DWORD 0
state0 BYTE "START GAME"
state1 BYTE "RULE"
state2 BYTE "SETTINGS"
gmode0 BYTE "GAMEMODE"
gmode00 BYTE "-USING [A][D] OR [LEFT][RIGHT]"
gmode1 BYTE "BATTLE"
gmode2 BYTE "TEAMWORK"
xy0 COORD <55,16>
xy1 COORD <58,19>
xy2 COORD <56,22>
xy3 COORD <56,5>
xy4 COORD <45,7>
xy5 COORD <37,13>
xy6 COORD <76,13>
xy7 COORD <58,5>
attri WORD 10 DUP(0Ch)
line1 BYTE 51 DUP(0C4h)
line2 BYTE 0B3h
Lxy1 COORD <4,12>
Lxy11 COORD <4,22>
Lxy2 COORD <3,13>
Lxy22 COORD <54,13>
Lxy3 COORD <66,12>
Lxy33 COORD <66,24>
Lxy4 COORD <65,13>
Lxy44 COORD <116,13>
rule1 BYTE "Rules for battle mode:"
rule2 BYTE "Players control a board only move up/down."
rule3 BYTE "Two white balls starting on each side."
rule4 BYTE "Left player use [W]/[S] control blue board."
rule5 BYTE "Right player use [UP]/[DOWN] control green board."
rule6 BYTE "Winner is who first clear all of its color."
rule7 BYTE "Rules for teamwork mode:"
rule8 BYTE "Ball starts at the left side."
rule9 BYTE "Left player moves the board with [w]/[s]."
rule10 BYTE "Right player moves the board with [UP]/[DOWN]."
rule11 BYTE "The goal is to clear all the blocks."
rule12 BYTE "The game ends when the ball touches the boundary."
rule13 BYTE "Speed changes when boards' edges touch the ball."
rulexy1 COORD <19,10>
rulexy2 COORD <5,13>
rulexy3 COORD <5,15>
rulexy4 COORD <5,17>
rulexy5 COORD <5,19>
rulexy6 COORD <5,21>
rulexy7 COORD <78,10>
rulexy8 COORD <67,13>
rulexy9 COORD <67,15>
rulexy10 COORD <67,17>
rulexy11 COORD <67,19>
rulexy12 COORD <67,21>
rulexy13 COORD <67,23>
resultPos1 COORD <36,3>
resultPos2 COORD <36,3>
resultPos3 COORD <40,7>
resultPos4 COORD <44,3>
resultPos5 COORD <51,3>
resultPos6 COORD <52,3>
resultPos7 COORD <52,6>
resultPos8 COORD <52,9>
resultPos9 COORD <64,3>
resultPos10 COORD <64,3>
resultPos11 COORD <70,3>
resultPos12 COORD <77,3>
resultPos13 COORD <77,9>
resultPos15 COORD <83,3>
M BYTE "M"
E BYTE "E"
N BYTE "N"
U BYTE "U"
.code
delayer PROC
	push ecx
	mov ecx, 300000000
L1:
	loop L1
	pop ecx
	ret
delayer ENDP
keyinput PROC
    .IF ax == 1177h
		.IF state >=1
			sub state,1
		.ENDIF
	.ENDIF
	.IF ax == 1F73h
		.IF state <= 1
			add state, 1
		.ENDIF
	.ENDIF
	.IF ax == 4800h
		.IF state >= 1
			sub state,1
		.ENDIF
	.ENDIF
	.IF ax == 5000h
		.IF state <= 1
			add state, 1
		.ENDIF
	.ENDIF
	.IF ax == 1C0Dh
		mov boolvalue, 1
	.ENDIF
keyinput ENDP
main PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle, eax
	INVOKE SetConsoleCursorInfo, consoleHandle, ADDR InfoCursor
Game:
	push eax
	push ebx
	push ecx
	push edx
	call ClrScr
	mov ecx, 7
	drawM1:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR M, 1, resultPos1, ADDR cellsWritten
		add resultPos1.y, 1
		pop ecx
		loop drawM1
		sub resultPos1.y, 7
	mov ecx, 4
	drawM2:
		push ecx
		add resultPos2.x, 1
		add resultPos2.y, 1
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR M, 1, resultPos2, ADDR cellsWritten
		pop ecx
		loop drawM2
		sub resultPos2.x, 4
		sub resultPos2.y, 4
	mov ecx, 3
	drawM3:
		push ecx
		add resultPos3.x, 1
		sub resultPos3.y, 1
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR M, 1, resultPos3, ADDR cellsWritten
		pop ecx 
		loop drawM3
		sub resultPos3.x, 3
		add resultPos3.y, 3
	mov ecx, 7
	drawM4:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR M, 1, resultPos4, ADDR cellsWritten
		add resultPos4.y, 1
		pop ecx
		loop drawM4
		sub resultPos4.y, 7
	mov ecx, 7
	drawE1:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR E, 1, resultPos5, ADDR cellsWritten
		add resultPos5.y, 1
		pop ecx
		loop drawE1
		sub resultPos5.y, 7
	mov ecx, 6
	drawE2:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR E, 1, resultPos6, ADDR cellsWritten
		add resultPos6.x, 1
		pop ecx
		loop drawE2
		sub resultPos6.x, 6
	mov ecx, 6
	drawE3:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR E, 1, resultPos7, ADDR cellsWritten
		add resultPos7.x, 1
		pop ecx
		loop drawE3
		sub resultPos7.x, 6
	mov ecx, 6
	drawE4:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR E, 1, resultPos8, ADDR cellsWritten
		add resultPos8.x, 1
		pop ecx
		loop drawE4
		sub resultPos8.x, 6
	mov ecx, 7
	drawN1:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR N, 1, resultPos9, ADDR cellsWritten
		add resultPos9.y, 1
		pop ecx
		loop drawN1
		sub resultPos9.y, 7
	mov ecx, 5
	drawN2:
		push ecx
		add resultPos10.y, 1
		add resultPos10.x, 1
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR N, 1, resultPos10, ADDR cellsWritten
		pop ecx
		loop drawN2
		sub resultPos10.y, 5
		sub resultPos10.x, 5
	mov ecx, 7
	drawN3:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR N, 1, resultPos11, ADDR cellsWritten
		add resultPos11.y, 1
		pop ecx
		loop drawN3
		sub resultPos11.y, 7
	mov ecx, 6
	drawU1:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR U, 1, resultPos12, ADDR cellsWritten
		add resultPos12.y, 1
		pop ecx
		loop drawU1
		sub resultPos12.y, 6
	mov ecx, 5
	drawU2:
		push ecx
		add resultPos13.x, 1
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR U, 1, resultPos13, ADDR cellsWritten
		pop ecx
		loop drawU2
		sub resultPos13.x, 5
	mov ecx, 6
	drawU3:
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR U, 1, resultPos15, ADDR cellsWritten
		add resultPos15.y, 1
		pop ecx
		loop drawU3
		sub resultPos15.y, 6
	.IF state == 0
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy0, ADDR bytesWritten
	.ENDIF
	.IF state == 1
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 4, xy1, ADDR bytesWritten
	.ENDIF
	.IF state == 2
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 8, xy2, ADDR bytesWritten
	.ENDIF
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR state0, 10, xy0, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR state1, 4, xy1, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR state2, 8, xy2, ADDR cellsWritten
	call delayer
	.IF boolvalue == 1
		.IF state == 0
			.IF gm == 0
				jmp vs
			.ENDIF
			.IF gm == 1
				jmp coop
			.ENDIF
		.ENDIF
		.IF state == 1
			jmp rule
		.ENDIF
		.IF state == 2
			jmp setting
		.ENDIF
	.ENDIF
    call Readkey
	jnz L1
	pop edx
	pop ecx
	pop ebx
	pop eax
	jmp Game
L1:
	call keyinput
	pop edx
	pop ecx
	pop ebx
	pop eax
	jmp Game
coop:
	mov boolvalue, 0
    call final1@0
	pop edx
	pop ecx
	pop ebx
	pop eax
	jmp Game
vs:
	mov boolvalue, 0
    call final@0
	pop edx
	pop ecx
	pop ebx
	pop eax
	jmp Game
rule:
	call ClrScr
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR state1, 4, xy7, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule1, 22, rulexy1, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule2, 42, rulexy2, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule3, 38, rulexy3, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule4, 43, rulexy4, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule5, 49, rulexy5, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule6, 43, rulexy6, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule7, 24, rulexy7, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule8, 29, rulexy8, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule9, 41, rulexy9, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule10, 46, rulexy10, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule11, 36, rulexy11, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule12, 49, rulexy12, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR rule13, 48, rulexy13, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR line1, 50, Lxy1, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR line1, 50, Lxy11, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR line1, 50, Lxy3, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR line1, 50, Lxy33, ADDR cellsWritten
	mov ecx, 9
	DrawL:
		push ecx
			INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR line2, 1, Lxy2, ADDR cellsWritten
			INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR line2, 1, Lxy22, ADDR cellsWritten
			add Lxy2.y, 1
			add Lxy22.y, 1
		pop ecx
		loop DrawL
		sub Lxy2.y, 9
		sub Lxy22.y, 9
	mov ecx, 11
	DrawL1:
		push ecx
			INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR line2, 1, Lxy4, ADDR cellsWritten
			INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR line2, 1, Lxy44, ADDR cellsWritten
			add Lxy4.y, 1
			add Lxy44.y, 1
		pop ecx
		loop DrawL1
		sub Lxy4.y, 11
		sub Lxy44.y, 11
	call delayer
	call Readkey
	jnz L2
	jmp rule
	L2:
		.IF ax == 1C0Dh
			mov boolvalue, 0
			pop edx
			pop ecx
			pop ebx
			pop eax
			jmp Game
		.ENDIF
		jmp rule
setting:
	call ClrScr
	.IF gm == 0
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 6, xy5, ADDR bytesWritten
	.ENDIF
	.IF gm == 1
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 8, xy6, ADDR bytesWritten
	.ENDIF
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gmode0, 8, xy3, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gmode00, 30, xy4, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gmode1, 6, xy5, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gmode2, 8, xy6, ADDR cellsWritten
	call delayer
	call Readkey
	jnz L3
	jmp setting
	L3:
		.IF ax == 1C0Dh
			mov boolvalue, 0
			pop edx
			pop ecx
			pop ebx
			pop eax
			jmp Game
		.ENDIF
		.IF ax == 1E61h
			mov gm, 0
		.ENDIF
		.IF ax == 2064h
			mov gm, 1
		.ENDIF
		.IF ax == 4B00h
			mov gm, 0
		.ENDIF
		.IF ax == 4D00h
			mov gm, 1
		.ENDIF
		jmp setting
    exit
main ENDP 
END main
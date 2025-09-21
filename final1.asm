include Irvine32.inc
EXTERN main@0:PROC
.STACK 200H
.data
len=1
blocklen=24
blsize=6
scMes BYTE " YOUR SCORE: "
winMes BYTE " MISSION COMPLETE "
loseMes BYTE " MISSION FAILED "
backMes BYTE " Press 'ENTER' Back to Menu "
scAttr WORD 13 DUP(0Eh)
loseAttr WORD 16 DUP(0Ch)
winAttr WORD 18 DUP(0Ah)
resultPos COORD <50,15>
score BYTE 0;
consoleHandle DWORD ?
xyBound1 COORD <116,28>
xyPos1A COORD <1,12>
xyPos2B COORD <115,12>
blPos1C COORD <48,5>
cellsWritten DWORD ?
CursorInfoC CONSOLE_CURSOR_INFO <1,0>
boardC BYTE 0B3h
ballxy1C COORD <31,16>
speed1C COORD <2,1>
speed2C COORD <2,3>
spp BYTE 0
ball3 BYTE 6Fh
LoseFlag BYTE 0h
bou BYTE "========================================================================================================================"
bouPos COORD <0,29>
block31 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block32 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block33 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block34 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block35 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block36 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block37 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block38 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block39 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block310 BYTE blsize DUP(5Bh,5Dh,20h,20h)
main EQU start@0

.code

stoppp PROC
	mov ecx, 300000000
L1:
	loop L1
	ret
stoppp ENDP

drawblocksC PROC
drawBL:
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block31, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block32, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block33, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block34, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block35, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block36, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block37, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block38, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block39, blocklen, blPos1C, ADDR cellsWritten
	add blPos1C.y, 2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block310, blocklen, blPos1C, ADDR cellsWritten
	sub blPos1C.y, 18
	ret
drawblocksC ENDP

listenerC PROC
	.IF ax == 1177h
		sub xyPos1A.y, 3
	.ENDIF
	.IF ax == 1F73h
		add xyPos1A.y, 3
	.ENDIF
	.IF ax == 4800h
		sub xyPos2B.y, 3
	.ENDIF
	.IF ax == 5000h
		add xyPos2B.y, 3
	.ENDIF

	.IF xyPos1A.y == -3
		add xyPos1A.y, 3
	.ENDIF
	mov ax, 27
	.IF xyPos1A.y >= ax
		sub xyPos1A.y, 3
	.ENDIF
	.IF xyPos2B.y == -3
		add xyPos2B.y, 3
	.ENDIF
	mov ax, 27
	.IF xyPos2B.y >= ax
		sub xyPos2B.y, 3
	.ENDIF
	ret
listenerC ENDP

ballrun PROC
	push bx
	push ax
	.IF spp == 0
		mov bx, speed1C.x
		add ballxy1C.x, bx
		mov bx, speed1C.y
		add ballxy1C.y, bx
	.ENDIF
	.IF spp == 1
		mov bx, speed2C.x
		add ballxy1C.x, bx
		mov bx, speed2C.y
		add ballxy1C.y, bx
	.ENDIF

	.IF ballxy1C.y <= 0h
		neg speed1C.y
		neg speed2C.y
	.ENDIF
	mov ax, xyBound1.y
	.IF ballxy1C.y >= ax
		neg speed1C.y
		neg speed2C.y
	.ENDIF
	.IF ballxy1C.x <= 0h
		mov LoseFlag, 1h
	.ENDIF
	mov ax, xyBound1.x
	.IF ballxy1C.x >= ax
		mov LoseFlag, 1h
	.ENDIF
	;
	push esi
	push ecx
	mov esi, 0
	mov cx, ballxy1C.x
L3:
	inc esi
	loop L3
	pop ecx
	sub esi, 48
	.IF ballxy1C.x >= 48
	.IF ballxy1C.x <= 72
		.IF ballxy1C.y == 5
			mov al, block31[esi]
			.IF al == 5Dh
				mov block31[esi], 20h
				mov block31[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 7
			mov al, block32[esi]
			.IF al == 5Dh
				mov block32[esi], 20h
				mov block32[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 9
			mov al, block33[esi]
			.IF al == 5Dh
				mov block33[esi], 20h
				mov block33[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 11
			mov al, block34[esi]
			.IF al == 5Dh
				mov block34[esi], 20h
				mov block34[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 13
			mov al, block35[esi]
			.IF al == 5Dh
				mov block35[esi], 20h
				mov block35[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 15
			mov al, block36[esi]
			.IF al == 5Dh
				mov block36[esi], 20h
				mov block36[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 17
			mov al, block37[esi]
			.IF al == 5Dh
				mov block37[esi], 20h
				mov block37[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 19
			mov al, block38[esi]
			.IF al == 5Dh
				mov block38[esi], 20h
				mov block38[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 21
			mov al, block39[esi]
			.IF al == 5Dh
				mov block39[esi], 20h
				mov block39[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
		.IF ballxy1C.y == 23
			mov al, block310[esi]
			.IF al == 5Dh
				mov block310[esi], 20h
				mov block310[esi-1], 20h
				neg speed1C.x
				neg speed2C.x
				add score,1
			.ENDIF
		.ENDIF
	.ENDIF
	.ENDIF
	pop esi
	;
	mov ax, xyPos1A.x
	.IF ballxy1C.x == ax
		mov ax, xyPos1A.y
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 1
		.ENDIF
		inc ax
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 0
		.ENDIF
		inc ax
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 0
		.ENDIF
		inc ax
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 0
		.ENDIF
		inc ax
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 1
		.ENDIF
	.ENDIF
	mov ax, xyPos2B.x
	.IF ballxy1C.x == ax
		mov ax, xyPos2B.y
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 1
		.ENDIF
		inc ax
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 0
		.ENDIF
		inc ax
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 0
		.ENDIF
		inc ax
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 0
		.ENDIF
		inc ax
		.IF ballxy1C.y == ax
			neg speed1C.x
			neg speed2C.x
			mov spp, 1
		.ENDIF
	.ENDIF
	pop ax
	pop bx
	ret
ballrun ENDP

LOSE PROC
	call Clrscr 
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR scAttr,13,resultPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR scMes, 13, resultPos, ADDR cellsWritten
	add resultPos.x, 13
	INVOKE SetConsoleCursorPosition, consoleHandle, resultPos
	movzx eax, score
	call WriteDec
	INVOKE SetConsoleCursorPosition, consoleHandle, xyPos1A
	add resultPos.y, 1
	sub resultPos.x, 13
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR loseAttr,16,resultPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR loseMes, 16, resultPos, ADDR cellsWritten
	add resultPos.y, 1
	sub resultPos.x, 4
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR backMes, 28, resultPos, ADDR cellsWritten
	sub resultPos.y, 2
	add resultPos.x, 4
	ret
LOSE ENDP

WIN PROC
	call Clrscr
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR scAttr,13,resultPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR scMes, 13, resultPos, ADDR cellsWritten
	add resultPos.x, 13
	INVOKE SetConsoleCursorPosition, consoleHandle, resultPos
	movzx eax, score
	call WriteDec
	INVOKE SetConsoleCursorPosition, consoleHandle, xyPos1A
	add resultPos.y, 1
	sub resultPos.x, 13
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR winAttr,18,resultPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR winMes, 18, resultPos, ADDR cellsWritten
	add resultPos.y, 1
	sub resultPos.x, 3
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR backMes, 28, resultPos, ADDR cellsWritten
	sub resultPos.y, 1
	add resultPos.x, 3
	ret
WIN ENDP

final1 PROC
	mov xyPos1A.x, 1
	mov xyPos1A.y, 12
	mov xyPos2B.x, 115
	mov xyPos2B.y, 12
	mov ballxy1C.x, 31
	mov ballxy1C.y, 16
	mov ecx, 6
	mov esi, 0
INITIAL1:
	mov block31[esi], 5Bh
	inc esi
	mov block31[esi], 5Dh
	inc esi
	mov block31[esi], 20h
	inc esi
	mov block31[esi], 20h
	inc esi
	loop INITIAL1
	mov ecx, 6
	mov esi, 0
INITIAL2:
	mov block32[esi], 5Bh
	inc esi
	mov block32[esi], 5Dh
	inc esi
	mov block32[esi], 20h
	inc esi
	mov block32[esi], 20h
	inc esi
	loop INITIAL2
	mov ecx, 6
	mov esi, 0
INITIAL3:
	mov block33[esi], 5Bh
	inc esi
	mov block33[esi], 5Dh
	inc esi
	mov block33[esi], 20h
	inc esi
	mov block33[esi], 20h
	inc esi
	loop INITIAL3
	mov ecx, 6
	mov esi, 0
INITIAL4:
	mov block34[esi], 5Bh
	inc esi
	mov block34[esi], 5Dh
	inc esi
	mov block34[esi], 20h
	inc esi
	mov block34[esi], 20h
	inc esi
	loop INITIAL4
	mov ecx, 6
	mov esi, 0
INITIAL5:
	mov block35[esi], 5Bh
	inc esi
	mov block35[esi], 5Dh
	inc esi
	mov block35[esi], 20h
	inc esi
	mov block35[esi], 20h
	inc esi
	loop INITIAL5
	mov ecx, 6
	mov esi, 0
INITIAL6:
	mov block36[esi], 5Bh
	inc esi
	mov block36[esi], 5Dh
	inc esi
	mov block36[esi], 20h
	inc esi
	mov block36[esi], 20h
	inc esi
	loop INITIAL6
	mov ecx, 6
	mov esi, 0
INITIAL7:
	mov block37[esi], 5Bh
	inc esi
	mov block37[esi], 5Dh
	inc esi
	mov block37[esi], 20h
	inc esi
	mov block37[esi], 20h
	inc esi
	loop INITIAL7
	mov ecx, 6
	mov esi, 0
INITIAL8:
	mov block38[esi], 5Bh
	inc esi
	mov block38[esi], 5Dh
	inc esi
	mov block38[esi], 20h
	inc esi
	mov block38[esi], 20h
	inc esi
	loop INITIAL8
	mov ecx, 6
	mov esi, 0
INITIAL9:
	mov block39[esi], 5Bh
	inc esi
	mov block39[esi], 5Dh
	inc esi
	mov block39[esi], 20h
	inc esi
	mov block39[esi], 20h
	inc esi
	loop INITIAL9
	mov ecx, 6
	mov esi,0
INITIAL10:
	mov block310[esi], 5Bh
	inc esi
	mov block310[esi], 5Dh
	inc esi
	mov block310[esi], 20h
	inc esi
	mov block310[esi], 20h
	inc esi
	loop INITIAL10
	mov LoseFlag, 0
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle, eax
	INVOKE SetConsoleCursorInfo, consoleHandle, ADDR CursorInfoC
START:
	push eax
	push ebx
	push ecx
	push edx
	call ClrScr
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR bou, 120, bouPos, ADDR cellsWritten
	push ecx
	mov ecx, 5
drawB:
	push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR boardC, len, xyPos1A, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR boardC, len, xyPos2B, ADDR cellsWritten
	add xyPos1A.y, 1
	add xyPos2B.y, 1
	pop ecx
	loop drawB
	pop ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR ball3, len, ballxy1C, ADDR cellsWritten
	sub xyPos1A.y, 5
	sub xyPos2B.y, 5
;end drawB
	call drawblocksC
	call ballrun
;lose
	.IF LoseFlag == 1
		mov LoseFlag, 0
		call LOSE
		mov score, 0
		L11:
			call Readkey
			jnz L12
			jmp L11
		L12:
			.IF	ax == 1C0Dh
				jmp END_FUNC
			.ENDIF
			jmp L11
	.ENDIF
	.IF score==60
		call WIN
		mov score, 0
		L13:
			call Readkey
			jnz L14
			jmp L13
		L14:
			.IF	ax == 1C0Dh
				jmp END_FUNC
			.ENDIF
			jmp L13
	.ENDIF
	call stoppp
	call Readkey
	jnz L2
	pop edx
	pop ecx
	pop ebx
	pop eax
	jmp START
L2:
	call listenerC
	jmp START
END_FUNC:
	call main@0
final1 ENDP
END final1
include Irvine32.inc
EXTERN main@0:PROC
.STACK 200H
.data
len=1
winlen=6
loselen=5
blocklen=24
blsize=6
boundwid=120
consoleHandle DWORD ?
xyBound COORD <120,27>
xyBBound COORD <116,28>
xyPos1 COORD <57,12>
xyPos2 COORD <63,12>
blPos1 COORD <0,4>
blPos2 COORD <97,4>
endxy1 COORD <30,14>
endxy2 COORD <90,14>
endxy3 COORD <60,0>
boundary1 COORD <120,0>
boundary2 COORD <0,28>
rPos COORD <47,28>
bxy1 BYTE 0B3h
bxy2 BYTE 120 DUP(0C4h)
cellsWritten DWORD ?
bytesWritten DWORD 0
CursorInfo CONSOLE_CURSOR_INFO <1,0>
board BYTE 0B3h
ballxy1 COORD <39,15>
ballxy2 COORD <81,14>
speed1 COORD <2,1>
speed2 COORD <-2,-1>
one BYTE 0h
two BYTE 0h
ball1 BYTE 6Fh
ball2 BYTE 6Fh
block11 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block12 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block13 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block14 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block15 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block16 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block17 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block18 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block19 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block110 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block21 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block22 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block23 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block24 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block25 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block26 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block27 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block28 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block29 BYTE blsize DUP(5Bh,5Dh,20h,20h)
block210 BYTE blsize DUP(5Bh,5Dh,20h,20h)
attributes0 WORD blocklen DUP(0Bh)
attributes1 WORD 0Ah
attributes2 WORD (blocklen-2) DUP(0Ah)
attributes3 WORD 0Bh
attributes4 WORD 6 DUP(0Ah)
attributes5 WORD 6 DUP(0Bh)
winner BYTE "WINNER"
loser BYTE "LOSER"
ending BYTE "Press 'ENTER' Back to Menu"
main EQU start@0
.code
stopp PROC
	push ecx
	mov ecx, 300000000
L1:
	loop L1
	pop ecx
	ret
stopp ENDP
drawblocks PROC
drawBL:
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block11, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block12, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block13, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block14, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block15, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block16, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block17, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block18, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block19, blocklen, blPos1, ADDR cellsWritten
	add blPos1.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, blocklen, blPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block110, blocklen, blPos1, ADDR cellsWritten
	sub blPos1.y, 18
	;
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block21, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block22, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block23, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block24, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block25, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block26, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block27, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block28, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block29, (blocklen-2), blPos2, ADDR cellsWritten
	add blPos2.y, 2
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, (blocklen-2), blPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR block210, (blocklen-2), blPos2, ADDR cellsWritten
	sub blPos2.y, 18
	ret
drawblocks ENDP
listener PROC
	.IF ax == 1177h
		sub xyPos1.y, 3
	.ENDIF
	.IF ax == 1F73h
		add xyPos1.y, 3
	.ENDIF
	.IF ax == 4800h
		sub xyPos2.y, 3
	.ENDIF
	.IF ax == 5000h
		add xyPos2.y, 3
	.ENDIF

	.IF xyPos1.y == -3
		add xyPos1.y, 3
	.ENDIF
	mov ax, xyBound.y
	.IF xyPos1.y == ax
		sub xyPos1.y, 3
	.ENDIF
	.IF xyPos2.y == -3
		add xyPos2.y, 3
	.ENDIF
	mov ax, xyBound.y
	.IF xyPos2.y == ax
		sub xyPos2.y, 3
	.ENDIF
	ret
listener ENDP
ballrun1 PROC
	push bx
	push ax
	mov bx, speed1.x
	add ballxy1.x, bx
	mov bx, speed1.y
	add ballxy1.y, bx
	.IF ballxy1.y <= 0h
		neg speed1.y
	.ENDIF
	mov ax, xyBBound.y
	.IF ballxy1.y >= ax
		neg speed1.y
	.ENDIF
	.IF ballxy1.x <= 0h
		neg speed1.x
	.ENDIF
	mov ax, xyBBound.x
	.IF ballxy1.x >= ax
		neg speed1.x
	.ENDIF
	;
	push esi
	push ecx
	mov esi, 0
	mov cx, ballxy1.x
L3:
	inc esi
	loop L3
	pop ecx
	.IF ballxy1.x <= 24
		.IF ballxy1.y == 4
			mov al, block11[esi]
			.IF al == 5Dh
				mov block11[esi], 20h
				mov block11[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 6
			mov al, block12[esi]
			.IF al == 5Dh
				mov block12[esi], 20h
				mov block12[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 8
			mov al, block13[esi]
			.IF al == 5Dh
				mov block13[esi], 20h
				mov block13[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 10
			mov al, block14[esi]
			.IF al == 5Dh
				mov block14[esi], 20h
				mov block14[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 12
			mov al, block15[esi]
			.IF al == 5Dh
				mov block15[esi], 20h
				mov block15[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 14
			mov al, block16[esi]
			.IF al == 5Dh
				mov block16[esi], 20h
				mov block16[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 16
			mov al, block17[esi]
			.IF al == 5Dh
				mov block17[esi], 20h
				mov block17[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 18
			mov al, block18[esi]
			.IF al == 5Dh
				mov block18[esi], 20h
				mov block18[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 20
			mov al, block19[esi]
			.IF al == 5Dh
				mov block19[esi], 20h
				mov block19[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 22
			mov al, block110[esi]
			.IF al == 5Dh
				mov block110[esi], 20h
				mov block110[esi-1], 20h
				neg speed1.x
				add one, 1
			.ENDIF
		.ENDIF
	.ENDIF
	;
	sub esi, 97
	.IF ballxy1.x >= 97
		.IF ballxy1.y == 4
			mov al, block21[esi]
			.IF al == 5Bh
				mov block21[esi], 20h
				mov block21[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 6
			mov al, block22[esi]
			.IF al == 5Bh
				mov block22[esi], 20h
				mov block22[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 8
			mov al, block23[esi]
			.IF al == 5Bh
				mov block23[esi], 20h
				mov block23[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 10
			mov al, block24[esi]
			.IF al == 5Bh
				mov block24[esi], 20h
				mov block24[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 12
			mov al, block25[esi]
			.IF al == 5Bh
				mov block25[esi], 20h
				mov block25[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 14
			mov al, block26[esi]
			.IF al == 5Bh
				mov block26[esi], 20h
				mov block26[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 16
			mov al, block27[esi]
			.IF al == 5Bh
				mov block27[esi], 20h
				mov block27[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 18
			mov al, block28[esi]
			.IF al == 5Bh
				mov block28[esi], 20h
				mov block28[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 20
			mov al, block29[esi]
			.IF al == 5Bh
				mov block29[esi], 20h
				mov block29[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy1.y == 22
			mov al, block210[esi]
			.IF al == 5Bh
				mov block210[esi], 20h
				mov block210[esi+1], 20h
				neg speed1.x
				add two, 1
			.ENDIF
		.ENDIF
	.ENDIF
	pop esi
	;
	mov ax, xyPos1.x
	.IF ballxy1.x == ax
		mov ax, xyPos1.y
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
		inc ax
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
		inc ax
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
		inc ax
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
		inc ax
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
	.ENDIF
	mov ax, xyPos2.x
	.IF ballxy1.x == ax
		mov ax, xyPos2.y
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
		inc ax
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
		inc ax
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
		inc ax
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
		inc ax
		.IF ballxy1.y == ax
			neg speed1.x
		.ENDIF
	.ENDIF
	pop ax
	pop bx
	ret
ballrun1 ENDP
ballrun2 PROC
	push bx
	push ax
	mov bx, speed2.x
	add ballxy2.x, bx
	mov bx, speed2.y
	add ballxy2.y, bx
	.IF ballxy2.y <= 0h
		neg speed2.y
	.ENDIF
	mov ax, xyBBound.y
	.IF ballxy2.y >= ax
		neg speed2.y
	.ENDIF
	.IF ballxy2.x <= 0h
		neg speed2.x
	.ENDIF
	mov ax, xyBBound.x
	.IF ballxy2.x >= ax
		neg speed2.x
	.ENDIF
	;
	push esi
	push ecx
	mov esi, 0
	mov cx, ballxy2.x
L5:
	inc esi
	loop L5
	pop ecx
	.IF ballxy2.x <= 24
		.IF ballxy2.y == 4
			mov al, block11[esi]
			.IF al == 5Dh
				mov block11[esi], 20h
				mov block11[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 6
			mov al, block12[esi]
			.IF al == 5Dh
				mov block12[esi], 20h
				mov block12[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 8
			mov al, block13[esi]
			.IF al == 5Dh
				mov block13[esi], 20h
				mov block13[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 10
			mov al, block14[esi]
			.IF al == 5Dh
				mov block14[esi], 20h
				mov block14[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 12
			mov al, block15[esi]
			.IF al == 5Dh
				mov block15[esi], 20h
				mov block15[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 14
			mov al, block16[esi]
			.IF al == 5Dh
				mov block16[esi], 20h
				mov block16[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 16
			mov al, block17[esi]
			.IF al == 5Dh
				mov block17[esi], 20h
				mov block17[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 18
			mov al, block18[esi]
			.IF al == 5Dh
				mov block18[esi], 20h
				mov block18[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 20
			mov al, block19[esi]
			.IF al == 5Dh
				mov block19[esi], 20h
				mov block19[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 22
			mov al, block110[esi]
			.IF al == 5Dh
				mov block110[esi], 20h
				mov block110[esi-1], 20h
				neg speed2.x
				add one, 1
			.ENDIF
		.ENDIF
	.ENDIF
	sub esi, 97
	.IF ballxy2.x >= 97
		.IF ballxy2.y == 4
			mov al, block21[esi]
			.IF al == 5Bh
				mov block21[esi], 20h
				mov block21[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 6
			mov al, block22[esi]
			.IF al == 5Bh
				mov block22[esi], 20h
				mov block22[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 8
			mov al, block23[esi]
			.IF al == 5Bh
				mov block23[esi], 20h
				mov block23[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 10
			mov al, block24[esi]
			.IF al == 5Bh
				mov block24[esi], 20h
				mov block24[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 12
			mov al, block25[esi]
			.IF al == 5Bh
				mov block25[esi], 20h
				mov block25[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 14
			mov al, block26[esi]
			.IF al == 5Bh
				mov block26[esi], 20h
				mov block26[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 16
			mov al, block27[esi]
			.IF al == 5Bh
				mov block27[esi], 20h
				mov block27[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 18
			mov al, block28[esi]
			.IF al == 5Bh
				mov block28[esi], 20h
				mov block28[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 20
			mov al, block29[esi]
			.IF al == 5Bh
				mov block29[esi], 20h
				mov block29[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
		.IF ballxy2.y == 22
			mov al, block210[esi]
			.IF al == 5Bh
				mov block210[esi], 20h
				mov block210[esi+1], 20h
				neg speed2.x
				add two, 1
			.ENDIF
		.ENDIF
	.ENDIF
	pop esi
	;
	mov ax, xyPos1.x
	.IF ballxy2.x == ax
		mov ax, xyPos1.y
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
		inc ax
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
		inc ax
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
		inc ax
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
		inc ax
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
	.ENDIF
	mov ax, xyPos2.x
	.IF ballxy2.x == ax
		mov ax, xyPos2.y
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
		inc ax
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
		inc ax
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
		inc ax
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
		inc ax
		.IF ballxy2.y == ax
			neg speed2.x
		.ENDIF
	.ENDIF
	pop ax
	pop bx
	ret
ballrun2 ENDP
final PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle, eax
	INVOKE SetConsoleCursorInfo, consoleHandle, ADDR CursorInfo
	mov xyPos1.x, 57
	mov xyPos1.y, 12
	mov xyPos2.x, 63
	mov xyPos2.y, 12
	mov blPos1.x, 0
	mov blPos1.y, 4
	mov blPos2.x, 97
	mov blPos1.y, 4
	mov ballxy1.x, 39
	mov ballxy1.y, 15
	mov ballxy2.x, 81
	mov ballxy2.y, 14
	mov speed1.x, 2
	mov speed1.y, 1
	mov speed2.x, -2
	mov speed2.y, -1
	mov one, 0
	mov two, 0
	push ecx
	push esi
	mov ecx, 6
	mov esi, 0
INITIAL1:
	mov block11[esi], 5Bh
	inc esi
	mov block11[esi], 5Dh
	inc esi
	mov block11[esi], 20h
	inc esi
	mov block11[esi], 20h
	inc esi
	loop INITIAL1
	mov ecx, 6
	mov esi, 0
INITIAL2:
	mov block12[esi], 5Bh
	inc esi
	mov block12[esi], 5Dh
	inc esi
	mov block12[esi], 20h
	inc esi
	mov block12[esi], 20h
	inc esi
	loop INITIAL2
	mov ecx, 6
	mov esi, 0
INITIAL3:
	mov block13[esi], 5Bh
	inc esi
	mov block13[esi], 5Dh
	inc esi
	mov block13[esi], 20h
	inc esi
	mov block13[esi], 20h
	inc esi
	loop INITIAL3
	mov ecx, 6
	mov esi, 0
INITIAL4:
	mov block14[esi], 5Bh
	inc esi
	mov block14[esi], 5Dh
	inc esi
	mov block14[esi], 20h
	inc esi
	mov block14[esi], 20h
	inc esi
	loop INITIAL4
	mov ecx, 6
	mov esi, 0
INITIAL5:
	mov block15[esi], 5Bh
	inc esi
	mov block15[esi], 5Dh
	inc esi
	mov block15[esi], 20h
	inc esi
	mov block15[esi], 20h
	inc esi
	loop INITIAL5
	mov ecx, 6
	mov esi, 0
INITIAL6:
	mov block16[esi], 5Bh
	inc esi
	mov block16[esi], 5Dh
	inc esi
	mov block16[esi], 20h
	inc esi
	mov block16[esi], 20h
	inc esi
	loop INITIAL6
	mov ecx, 6
	mov esi, 0
INITIAL7:
	mov block17[esi], 5Bh
	inc esi
	mov block17[esi], 5Dh
	inc esi
	mov block17[esi], 20h
	inc esi
	mov block17[esi], 20h
	inc esi
	loop INITIAL7
	mov ecx, 6
	mov esi, 0
INITIAL8:
	mov block18[esi], 5Bh
	inc esi
	mov block18[esi], 5Dh
	inc esi
	mov block18[esi], 20h
	inc esi
	mov block18[esi], 20h
	inc esi
	loop INITIAL8
	mov ecx, 6
	mov esi, 0
INITIAL9:
	mov block19[esi], 5Bh
	inc esi
	mov block19[esi], 5Dh
	inc esi
	mov block19[esi], 20h
	inc esi
	mov block19[esi], 20h
	inc esi
	loop INITIAL9
	mov ecx, 6
	mov esi,0
INITIAL10:
	mov block110[esi], 5Bh
	inc esi
	mov block110[esi], 5Dh
	inc esi
	mov block110[esi], 20h
	inc esi
	mov block110[esi], 20h
	inc esi
	loop INITIAL10
	;
	mov ecx, 6
	mov esi, 0
INITIAL11:
	mov block21[esi], 5Bh
	inc esi
	mov block21[esi], 5Dh
	inc esi
	mov block21[esi], 20h
	inc esi
	mov block21[esi], 20h
	inc esi
	loop INITIAL11
	mov ecx, 6
	mov esi, 0
INITIAL12:
	mov block22[esi], 5Bh
	inc esi
	mov block22[esi], 5Dh
	inc esi
	mov block22[esi], 20h
	inc esi
	mov block22[esi], 20h
	inc esi
	loop INITIAL12
	mov ecx, 6
	mov esi, 0
INITIAL13:
	mov block23[esi], 5Bh
	inc esi
	mov block23[esi], 5Dh
	inc esi
	mov block23[esi], 20h
	inc esi
	mov block23[esi], 20h
	inc esi
	loop INITIAL13
	mov ecx, 6
	mov esi, 0
INITIAL14:
	mov block24[esi], 5Bh
	inc esi
	mov block24[esi], 5Dh
	inc esi
	mov block24[esi], 20h
	inc esi
	mov block24[esi], 20h
	inc esi
	loop INITIAL14
	mov ecx, 6
	mov esi, 0
INITIAL15:
	mov block25[esi], 5Bh
	inc esi
	mov block25[esi], 5Dh
	inc esi
	mov block25[esi], 20h
	inc esi
	mov block25[esi], 20h
	inc esi
	loop INITIAL15
	mov ecx, 6
	mov esi, 0
INITIAL16:
	mov block26[esi], 5Bh
	inc esi
	mov block26[esi], 5Dh
	inc esi
	mov block26[esi], 20h
	inc esi
	mov block26[esi], 20h
	inc esi
	loop INITIAL16
	mov ecx, 6
	mov esi, 0
INITIAL17:
	mov block27[esi], 5Bh
	inc esi
	mov block27[esi], 5Dh
	inc esi
	mov block27[esi], 20h
	inc esi
	mov block27[esi], 20h
	inc esi
	loop INITIAL17
	mov ecx, 6
	mov esi, 0
INITIAL18:
	mov block28[esi], 5Bh
	inc esi
	mov block28[esi], 5Dh
	inc esi
	mov block28[esi], 20h
	inc esi
	mov block28[esi], 20h
	inc esi
	loop INITIAL18
	mov ecx, 6
	mov esi, 0
INITIAL19:
	mov block29[esi], 5Bh
	inc esi
	mov block29[esi], 5Dh
	inc esi
	mov block29[esi], 20h
	inc esi
	mov block29[esi], 20h
	inc esi
	loop INITIAL19
	mov ecx, 6
	mov esi,0
INITIAL20:
	mov block210[esi], 5Bh
	inc esi
	mov block210[esi], 5Dh
	inc esi
	mov block210[esi], 20h
	inc esi
	mov block210[esi], 20h
	inc esi
	loop INITIAL20
	pop esi
	pop ecx
START:
	push eax
	push ebx
	push ecx
	push edx
	call ClrScr
	push ecx
	mov ecx, 5
drawB:
	push ecx
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes0, len, xyPos1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR board, len, xyPos1, ADDR cellsWritten
	add xyPos1.y, 1
	pop ecx
	loop drawB
	mov ecx, 5
drawB2:
	push ecx
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes2, len, xyPos2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR board, len, xyPos2, ADDR cellsWritten
	add xyPos2.y, 1
	pop ecx
	loop drawB2
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR ball1, len, ballxy1, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR ball2, len, ballxy2, ADDR cellsWritten
	sub xyPos1.y, 5
	sub xyPos2.y, 5
	mov ecx, 28
L8:
	push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR bxy1, len, boundary1, ADDR cellsWritten
	add boundary1.y, 1
	pop ecx
	loop L8
	sub boundary1.y, 28
	pop ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR bxy2, boundwid, boundary2, ADDR cellsWritten
;end L8
	call drawblocks
	call ballrun1
	call ballrun2
	call stopp
	.IF one == 60
		jmp win1
	.ENDIF
	.IF two == 60
		jmp win2
	.ENDIF
	call Readkey
	jnz L2
	pop edx
	pop ecx
	pop ebx
	pop eax
	jmp START
L2:
	call listener
	pop edx
	pop ecx
	pop ebx
	pop eax
	jmp START
win1:
	call ClrScr
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR ending, 26, rPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes5, winlen, endxy1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR winner, winlen, endxy1, ADDR cellsWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes4, loselen, endxy2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR loser, loselen, endxy2, ADDR cellsWritten
	push ecx
	mov ecx, 25
L9:
	push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR bxy1, len, endxy3, ADDR cellsWritten
	add endxy3.y, 1
	pop ecx
	loop L9
	sub endxy3.y, 25
	pop ecx
	call stopp
	call Readkey
	jnz back
	jmp win1
	back:
		.IF ax == 1C0Dh
			jmp END_FUNC
		.ENDIF
		jmp win1
win2:
	call ClrScr
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR ending, 26, rPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes4, winlen, endxy2, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR winner, winlen, endxy2, ADDR cellsWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attributes5, loselen, endxy1, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR loser, loselen, endxy1, ADDR cellsWritten
	push ecx
	mov ecx, 25
L10:
	push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR bxy1, len, endxy3, ADDR cellsWritten
	add endxy3.y, 1
	pop ecx
	loop L10
	sub endxy3.y, 25
	pop ecx
	call stopp
	call Readkey
	jnz back1
	jmp win2
	back1:
		.IF ax == 1C0Dh
			jmp END_FUNC
		.ENDIF
		jmp win2
END_FUNC:
	call main@0
final ENDP
END final
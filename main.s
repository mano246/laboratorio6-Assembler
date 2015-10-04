.section .init
.globl _start
_start:

b main

.section .text
main:
	mov sp,#0x8000
	
	mov r0,#1024
	mov r1,#768
	mov r2,#16
	bl InitialiseFrameBuffer

	teq r0,#0
	bne noError$
	
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction

	mov r0,#16
	mov r1,#0
	bl SetGpio

	error$:
		b error$
		
	noError$:
		mov r4,r0
		
		//Empieza el ciclo infinito de filas y columnas
		draw:
			/*
			*ldr r2, = fondoHeight
			*ldr r2, [r2]				//y
			*ldr r3, = fondoWidth
			*ldr r3, [r3]				//x
			*ldr r4, [r4, #32]			//fbAddr
			*ldr r5, =fondo
			*push {r5}
			*bl drawImage
			*/
			
			ldr r2, = nemoHeight
			ldr r2, [r2]				//y
			ldr r3, = nemoWidth
			ldr r3, [r3]				//x
			ldr r4, [r4, #32]			//fbAddr
			ldr r5, =nemo
			push {r5}
			bl drawImage
			
		b draw
			
drawImage:
	pop {r5}
	push {lr}
	mov r6, #0
	mov r7, #0
	inicioC:
		inicioR:
			ldrh r6, [r5, r7]
			strh r6, [r4]
			add r4, #2
			add r7, #2
			sub r3, #1
			
			teq r3, #0
			bne inicioR
			
		ldr r8,=1848 	//(1024-100)*2=1848		//Estas dos líneas solo van a servir para cuando es nemo.
		add r4,r8
		
		sub r2, #1
		teq r2, #0
		bne inicioC
	pop {pc}
		

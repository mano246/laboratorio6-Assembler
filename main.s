
.section .init
.globl _start
_start:

b main

.section .text
main:
	mov sp,#0x8000


	//Inicializacion de la pantalla con resolucion 1024x768.
	mov r0,#1024
	mov r1,#768
	mov r2,#16
	bl InitialiseFrameBuffer

	//Manejo del error al no poder reservar el frame buffer
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

	//Pantalla Inicializada correctamente
	noError$:
	
	//fbInfoAddr es la direccion a la tabla con la informacion de la pantalla.
	fbInfoAddr .req r1
	mov fbInfoAddr,r0
	
	initDrawFondo: 
		fbAddr .req r5
		ldr fbAddr,[fbInfoAddr,#32]
		
		mov r6,#0			//countByte
		
		ldr r4, = fondo 
		ldr r2, = fondoHeight
		ldrh r2, [r2]
		ldr r3, = fondoWidth
		ldrh r3, [r3]
		bl drawImage
		
		/*
		*mov r6,#0
		*ldr r4, = nemo
		*ldr r2, = nemoHeight
		*ldrh r2, [r2]
		*ldr r3, = nemoWidth
		*ldrh r3, [r3]
		*bl drawImage
		*/
		b initDrawFondo
		
			
		

			
			
		

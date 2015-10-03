/*
* Entradas:
*	r0, =  x
* 	r1, = y
*	r2, = alto imagen-
* 	r3, = ancho imagen-
*	r4, = puntero a dirección de los colores-
*	r5, = puntero de frameBuffer
*/
.globl drawImage
drawImage:
	push {lr}
	initDrawImage:
		ldr r3, = fondoWidth
		ldrh r3, [r3]
		
		eachPixelFondo: 
			ldrh r7, [r4, r6]
			strh r7, [r5]
			add r5, #2
			add r6, #2
			sub r3, #1
			
			teq r3, #0
			bne eachPixelFondo
		
		/*
		*ldr r8,=1848 	//(1024-100)*2=1848
		*add r5,r8
		*/
		sub r2, #1
		
		teq r2, #0
		bne initDrawImage
	pop {pc}
	

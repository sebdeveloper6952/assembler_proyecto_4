/* Archivo con subrutinas utilizadas en alarma.s */
.text
.balign 2
@********************************************************
@******************** ObtenerDigitos ********************
@*********************** INPUT **************************
@ r0 = numero entre 0 y 99
@*********************** OUTPUT *************************
@ r0 = digito 1
@ r1 = digito 2 (si es menor a 10, r1 = -1)
.global ObtenerDigitos
ObtenerDigitos:
  cmp r0, #0
  movlt r0, #-1
  movlt r1, #-1
  movlt pc, lr
  cmp r0, #99
  movgt r0, #-1
  movgt r1, #-1
  movgt pc, lr
  mov r1, r0
  mov r0, #0
  div_loop:
    cmp r1, #10
    subges r1, #10
    addge r0, #1
    bgt div_loop
  mov pc, lr
@********************************************************

@********************************************************
@******************* Escribir Digito 1 ******************
@*********************** INPUT **************************
@ r0 contiene digito 1 de numero de 2 digitos, se escribe
@ a 4 pines correspondientes a 1 decodificador 74LS48
@*********************** OUTPUT *************************
@ Escribe los bits adecuados a los pines correspondientes
@ del decodificador. Los pines utilizados son, del menos
@ significativo al mas significativo: 14, 15, 18, 23
.global EscribirDigito1
EscribirDigito1:
  push {r4,r5,lr}
  @guardar digito en r4
  mov r4, r0

  @bit 0
  mov r5, #1
  and r3, r4, r5
  cmp r3, r5
  mov r0, #14
  moveq r1, #1
  movne r1, #0
  bl SetGpio
  
  @bit 1
  lsl r5, #1
  and r3, r4, r5
  cmp r3, r5
  mov r0, #15
  moveq r1, #1
  movne r1, #0
  bl SetGpio

  @bit 2
  lsl r5, #1
  and r3, r4, r5
  cmp r3, r5
  mov r0, #18
  moveq r1, #1
  movne r1, #0
  bl SetGpio

  @bit 3
  lsl r5, #1
  and r3, r4, r5
  cmp r3, r5
  mov r0, #23
  moveq r1, #1
  movne r1, #0
  bl SetGpio

  pop {r4,r5,pc}
@********************************************************

@********************************************************
@******************* Escribir Digito 2 ******************
@*********************** INPUT **************************
@ r0 contiene digito 1 de numero de 2 digitos, se escribe
@ a 4 pines correspondientes a 1 decodificador 74LS48
@*********************** OUTPUT *************************
@ Escribe los bits adecuados a los pines correspondientes
@ del decodificador. Los pines utilizados son, del menos
@ significativo al mas significativo: 24, 25, 8, 7
.global EscribirDigito2
EscribirDigito2:
  push {r4,r5,lr}
  @guardar digito en r4
  mov r4, r0

  @bit 0
  mov r5, #1
  and r3, r4, r5
  cmp r3, r5
  mov r0, #24
  moveq r1, #1
  movne r1, #0
  bl SetGpio
  
  @bit 1
  lsl r5, #1
  and r3, r4, r5
  cmp r3, r5
  mov r0, #25
  moveq r1, #1
  movne r1, #0
  bl SetGpio

  @bit 2
  lsl r5, #1
  and r3, r4, r5
  cmp r3, r5
  mov r0, #8
  moveq r1, #1
  movne r1, #0
  bl SetGpio

  @bit 3
  lsl r5, #1
  and r3, r4, r5
  cmp r3, r5
  mov r0, #7
  moveq r1, #1
  movne r1, #0
  bl SetGpio

  pop {r4,r5,pc}
@********************************************************
    
  

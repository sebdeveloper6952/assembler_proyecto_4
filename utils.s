/* Archivo con subrutinas utilizadas en alarma.s */

@********************************************************
@******************** ObtenerDigitos ********************
@************************INPUT **************************
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
    subgts r1, #10
    addgt r0, #1
    bgt div_loop
  mov pc, lr

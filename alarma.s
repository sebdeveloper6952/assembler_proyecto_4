/* Proyecto 4 - Programa Principal - Alarma */

.global main
.func main
main:
 /* @utilizar libreria lib_gpio
  mov r0, #3
  bl GetGpioAddress
  
  @configurar pines como salida
  mov r0, #14
  mov r1, #1
  bl SetGpioFunction
  mov r0, #15
  mov r1, #1
  bl SetGpioFunction
  mov r0, #18
  mov r1, #1
  bl SetGpioFunction
  mov r0, #23
  mov r1, #1
  bl SetGpioFunction

  @prueba para escribir numero a pines
  mov r0, #60
  bl ObtenerDigitos
  mov r4, r0
  mov r5, r1
  
  @escribir digitos a pines
  mov r0, r4
  bl EscribirDigito1
  mov r0, r5
  bl EscribirDigito2 */
  
  @prueba delay 1 segundo
  mov r4, #0
  loop:
    bl wait1s
    add r4, r4, #1
    mov r1, r4
    ldr r0, =num
    bl printf
  bal loop
  
exit:
  mov r7, #1
  svc 0

wait1s:
  push {r4, r5, lr}
  bl getCPS
  vmov s2, r0
  vcvt.f32.s32 s2, s2 @ CPS
  ldr r1, addr_floatOne
  vldr s6, [r1]              @s6 = 1f
  ldr r1, addr_floatZero
  vldr s5, [r1]              @s5 = 0f
  wait1s_loop:
    bl getCycles
    mov r4, r0
    bl delay
    bl getCycles
    mov r5, r0
    sub r5, r5, r4
    vmov s3, r5
    vcvt.f32.s32 s3, s3
    vdiv.f32 s4, s3, s2    @diff / CPS
    vadd.f32 s5, s5, s4
    vcmp.f32 s6, s5
    vmrs apsr_nzcv, fpscr
    bgt wait1s_loop
  pop {r4, r5, pc}

delay:
  mov r0, #0xF00000
  delay_loop:
    subs r0, #1
    bne delay_loop
  mov pc, lr

addr_floatOne: .word floatOne
addr_floatZero: .word floatZero
  
.data
  cps: .word 0
  num: .asciz "%d\n"
  msgCPS: .asciz "CPS: %d\n"
  time: .asciz "Time: %15.10f\n"
  floatOne: .float 1.000000
  floatZero: .float 0.000000

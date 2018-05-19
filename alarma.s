/* Proyecto 4 - Programa Principal - Alarma */

.global main
.func main
main:
  @utilizar libreria lib_gpio
  mov r0, #3
  bl GetGpioAddress
  
  @configurar pines como salida
  @digito 1
  mov r0, #14
  mov r1, #1
  bl SetGpioFunction
  mov r0, #15
  mov r1, #1
  bl SetGpioFunction
  mov r0, #17
  mov r1, #1
  bl SetGpioFunction
  mov r0, #18
  mov r1, #1
  bl SetGpioFunction
  @digito 2
  mov r0, #22
  mov r1, #1
  bl SetGpioFunction
  mov r0, #23
  mov r1, #1
  bl SetGpioFunction
  mov r0, #24
  mov r1, #1
  bl SetGpioFunction
  mov r0, #25
  mov r1, #1
  bl SetGpioFunction
  @todos los pines en bajo
  mov r0, #14
  mov r1, #0
  bl SetGpio
  mov r0, #15
  mov r1, #0
  bl SetGpio
  mov r0, #17
  mov r1, #0
  bl SetGpio
  mov r0, #18
  mov r1, #0
  bl SetGpio
  mov r0, #22
  mov r1, #0
  bl SetGpio
  mov r0, #23
  mov r1, #0
  bl SetGpio
  mov r0, #24
  mov r1, #0
  bl SetGpio
  mov r0, #25
  mov r1, #0
  bl SetGpio
  
  @configurar alarmas
  ldr r0, =msgMenu
  bl printf
  ldr r0, =msgSoftware
  bl printf
  ldr r0, =msgBotones
  bl printf
  ldr r0, =msgIngreseOpcion
  bl printf
  ldr r0, addr_fmtInt
  ldr r1, =opcionIngresada
  bl scanf
  ldr r0, =opcionIngresada
  ldr r0, [r0]
  cmp r0, #2
  beq programar_por_botones
  
@programar por software
programar_por_software:
  ldr r0, =msgIngreseAlarma
  bl printf
  ldr r0, addr_fmtInt
  ldr r1, addr_alarma0
  bl scanf
  b iniciar_alarma

  @programar por botones
  programar_por_botones:
  
  
  @prueba delay 1 segundo
iniciar_alarma:
  mov r4, #0                  @contador de alarma
  ldr r7, addr_alarma0        @cargar alarma configurada por usuario
  ldr r7, [r7]
  loop:
    bl wait1s             @espera de 1 segundo
    add r4, r4, #1        @incrementar contador de alarma
    cmp r4, #60
    moveq r4, #0
    mov r0, r4
    bl ObtenerDigitos     @r0 = digito 1; r1 = digito 2
    mov r5, r0
    mov r6, r1
    ldr r0, =num
    mov r1, r5
    mov r2, r6
    bl printf
    mov r0, r5
    bl EscribirDigito1
    mov r0, r6 
    bl EscribirDigito2
    cmp r7, r4
    beq sonar_alarma
  bal loop

sonar_alarma:
  ldr r0, =msgSonarAlarma
  bl printf
  
exit:
  mov r7, #1
  svc 0

@subrutinas
wait1s:
  push {r4, r5, lr}
  bl getCPS
  vmov s2, r0
  vcvt.f32.s32 s2, s2           @ CPS
  ldr r1, addr_floatOne 
  ldr r1, [r1]
  vmov s6, r1                   @ s6 = 0.00000
  ldr r1, addr_floatZero
  ldr r1, [r1]
  vmov s5, r1                   @ s5 = 1.00000
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
addr_fmtInt: .word fmtInt
addr_alarma0: .word alarma0
  
.data
.align 4
  num: .asciz "%d %d \n"
  fmtInt: .asciz "%d"
  opcionIngresada: .word 0
  msgMenu: .asciz "***************** Menu ****************** \n"
  msgSoftware: .asciz "1. Programar alarmas por medio del programa. \n"
  msgBotones: .asciz "2. Programar alarmas por medio de botones. \n"
  msgIngreseOpcion: .asciz "Ingrese opcion: \n"
  msgIngreseAlarma: .asciz "Ingrese a que segundo suena la alarma (0 - 60): \n"
  msgSonarAlarma: .asciz "DESPIEEEEEEERTEEEEEEESEEEEEEE!\n"
  floatOne: .float 1.000000
  floatZero: .float 0.000000
  alarma0: .word 0

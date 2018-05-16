// Universidad del Valle de Guatemala
// Taller de Assembler 2016
// C library to mannage time from ASM
// Christian Medina Armas
// AGO-2016

#include <time.h>
#include <stdio.h>

int getCycles(void){
  clock_t cycles;
  cycles = clock();
  return((int) cycles);
}

int getCPS(void){
  return((int)CLOCKS_PER_SEC);
}

float timePassed(int cycles) {
  return ((float)(cycles)/CLOCKS_PER_SEC);
}

void wait(int ms) {
  long pause;
  clock_t now,then;

  pause = ms*(CLOCKS_PER_SEC/1000);
  now = then = clock();
  while((now-then) < pause)
    now = clock();
}


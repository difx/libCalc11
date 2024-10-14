#include <stdio.h>
#include "calc11.h"

#define MAXSTATION 5


void printDelay(double **delay) {
  int i;
  for (int i=0; i<3; i++) {
    printf("[%0.9f", delay[i][0]);
    for (int j=1; j<CALC_POLY_ORDER+1; j++) {
      printf(", %0.9e", delay[i][j]);
    }
    printf("]\n");
  }
}


int main(void) {
  int result;
  double **delay, **wet, **dry, **Az, **El, **U, **V, **W;

  result = allocate_coeffs(MAXSTATION, &delay, &wet, &dry, &Az, &El, &U, &V, &W);

  calcinit_c();

  //result = load_ant_c("AK01", "AZEL", 0.00000, -2556088.476234,   5097405.971301,   -2848428.398018);
  //result = load_ant_c("AK02", "AZEL", 0.00000, -2556109.97953037, 5097388.70113492, -2848440.13354315);
  //result = load_ant_c("AK03", "AZEL", 0.00000, -2556121.90976612, 5097392.35165232, -2848421.53643228);
  result = load_ant_c("PA", "AZEL", -0.01940, -4554232.74080, 2816758.85900, -3454034.69880);
  result = load_ant_c("CD", "AZEL",  0.00240, -3753442.74570, 3912709.75300, -3348067.60950);
  result = load_ant_c("WW", "AZEL",  0.00210, -5115324.57200,  477843.27700, -3767192.60920);

  result = load_eop_c(60252, 37, 0.2672, 0.2618,  0.01248);
  result = load_eop_c(60253, 37, 0.2654, 0.2600,  0.01287);
  result = load_eop_c(60254, 37, 0.2636, 0.2583,  0.01312);
  result = load_eop_c(60255, 37, 0.2618, 0.2567,  0.01318);
  result = load_eop_c(60256, 37, 0.2599, 0.2550,  0.01304);
  result = load_eop_c(60257, 37, 0.2581, 0.2534,  0.01272);
     
  dinitl_c();

  result = load_source_c("Test1", 1.4, -1.0);
  result = runcalc2_c(60255.68611111111111111111, delay[0], U[0], V[0], W[0], MAXSTATION);
  if (result!=0) {
    printf("Error (%d) running calc!", result);
  } else {
    printDelay(delay);
  }

  printf("\n\n");
  
  result =  load_source_c("Test2", 0.4, -1.0);
  result = runcalc2_c(60255.5, delay[0], U[0], V[0], W[0], MAXSTATION);
  if (result!=0) {
    printf("Error (%d) running calc!", result);
  } else {
    printDelay(delay);
  }

  
  free_coeffs(MAXSTATION, delay, wet, dry, Az, El, U, V, W);
  
  return(0);
  
}

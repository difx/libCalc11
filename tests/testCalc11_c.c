#include "calc11.h"

int main(void) {
  int result;
  
  calcinit_c();

  result = load_ant_c("AK01", "AZEL", 0.00000, -2556088.476234,   5097405.971301,   -2848428.398018);
  result = load_ant_c("AK02", "AZEL", 0.00000, -2556109.97953037, 5097388.70113492, -2848440.13354315);
  result = load_ant_c("AK03", "AZEL", 0.00000, -2556121.90976612, 5097392.35165232, -2848421.53643228);

  result = load_eop_c(60252, 37, 0.2672, 0.2618,  0.01248);
  result = load_eop_c(60253, 37, 0.2654, 0.2600,  0.01287);
  result = load_eop_c(60254, 37, 0.2636, 0.2583,  0.01312);
  result = load_eop_c(60255, 37, 0.2618, 0.2567,  0.01318);
  result = load_eop_c(60256, 37, 0.2599, 0.2550,  0.01304);
  result = load_eop_c(60257, 37, 0.2581, 0.2534,  0.01272);
     

  dinitl_c();

  result = load_source_c(1, "1934-638", 5.1, -1.0);
  runcalc_c(60255.68715277778, 60255.6870);

  //call load_source(1, 'Test', 4.9d0, -1.0d0);
  //call runcalc(60255.78715277778, 60255.7875);

  return(0);
  
}

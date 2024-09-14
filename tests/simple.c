#include <stdlib.h>
#include <stdio.h>

int return_double(double*, int);

int main() {
  int result;
  double **test;

  
  test = (double**)malloc(sizeof(double*)*2);
  test[0] = malloc(sizeof(double)*4);
  test[1] = test[0]+2;
  
  result = return_double(*test, 2);

  printf("Got %f %f %f %f\n", (*test)[0], (*test)[1], (*test)[2], (*test)[3]);

  return(0);
}

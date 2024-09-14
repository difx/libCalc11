#include <stdlib.h>
#include "calc11.h"

int allocate_coeffs(int nPoly, double ***delay, double ***wet, double ***dry, 
                    double ***Az, double ***El, double ***U, double ***V, double ***W) {

  // Ensure NULL
  *delay = NULL;
  *wet   = NULL;
  *dry   = NULL;
  *Az    = NULL;
  *El    = NULL;
  *U     = NULL;
  *V     = NULL;
  *W     = NULL;

  *delay = (double **)malloc(nPoly * sizeof(double *));
  *wet   = (double **)malloc(nPoly * sizeof(double *));
  *dry   = (double **)malloc(nPoly * sizeof(double *));
  *Az    = (double **)malloc(nPoly * sizeof(double *));
  *El    = (double **)malloc(nPoly * sizeof(double *));
  *U     = (double **)malloc(nPoly * sizeof(double *));
  *V     = (double **)malloc(nPoly * sizeof(double *));
  *W     = (double **)malloc(nPoly * sizeof(double *));

  
  // Check if any allocation failed
  if (!(*delay) || !(*wet) || !(*dry) || !(*Az) || !(*El) || !(*U) || !(*V) || !(*W)) {
    // Free any memory that was successfully allocated before returning
    free(*delay); free(*wet); free(*dry); free(*Az); free(*El); free(*U); free(*V); free(*W);
    return -1; // Allocation failed
  }

  // Allocate memory for all rows in the arrays - this ensure contigious in memory which fortran needs
  (*delay)[0] = (double *)malloc((CALC_POLY_ORDER + 1) * nPoly * sizeof(double));
  (*wet)[0]   = (double *)malloc((CALC_POLY_ORDER + 1) * nPoly * sizeof(double));
  (*dry)[0]   = (double *)malloc((CALC_POLY_ORDER + 1) * nPoly * sizeof(double));
  (*Az)[0]    = (double *)malloc((CALC_POLY_ORDER + 1) * nPoly * sizeof(double));
  (*El)[0]    = (double *)malloc((CALC_POLY_ORDER + 1) * nPoly * sizeof(double));
  (*U)[0]     = (double *)malloc((CALC_POLY_ORDER + 1) * nPoly * sizeof(double));
  (*V)[0]     = (double *)malloc((CALC_POLY_ORDER + 1) * nPoly * sizeof(double));
  (*W)[0]     = (double *)malloc((CALC_POLY_ORDER + 1) * nPoly * sizeof(double));

  // Check if any allocation failed
  if (!(*delay)[0] || !(*wet)[0] || !(*dry)[0] || !(*Az)[0] ||!(*El)[0] || !(*U)[0] || !(*V)[0] || !(*W)[0])  {
    // Free any memory that was successfully allocated before returning
    free((*delay)[0]); free((*wet)[0]); free((*dry)[0]); free((*Az)[0]);
    free((*El)[0]); free((*U)[0]); free((*V)[0]); free((*W)[0]);
    free(*delay); free(*wet); free(*dry); free(*Az);  free(*El); free(*U); free(*V); free(*W);
    return -1; // Allocation failed
  }

  for (int i = 1; i<nPoly; i++) {
    (*delay)[i] = *delay[0] + (CALC_POLY_ORDER+1)*i;
    (*wet)[i] = *wet[0] + (CALC_POLY_ORDER+1)*i;
    (*dry)[i] = *dry[0] + (CALC_POLY_ORDER+1)*i;
    (*Az)[i] = *Az[0] + (CALC_POLY_ORDER+1)*i;
    (*El)[i] = *El[0] + (CALC_POLY_ORDER+1)*i;
    (*U)[i] = *U[0] + (CALC_POLY_ORDER+1)*i;
    (*V)[i] = *V[0] + (CALC_POLY_ORDER+1)*i;
    (*W)[i] = *W[0] + (CALC_POLY_ORDER+1)*i;
  }
  return 0;
}


void free_coeffs(int nPoly, double **delay, double **wet, double **dry, 
                 double **Az, double **El, double **U, double **V, double **W) {
  free(delay[0]);
  free(wet[0]);
  free(dry[0]);
  free(Az[0]);
  free(El[0]);
  free(U[0]);
  free(V[0]);
  free(W[0]);

  // Free the pointers to the rows
  free(delay);
  free(wet);
  free(dry);
  free(Az);
  free(El);
  free(U);
  free(V);
  free(W);
}

#if 0
int main() {
    double **delay, **wet, **dry, **Az, **El, **U, **V, **W;
    int nPoly = 10;

    int result = allocate_coeffs(nPoly, CALC_POLY_ORDER, &delay, &wet, &dry, &Az, &El, &U, &V, &W);
    
    if (result == 0) {
        printf("Arrays allocated successfully.\n");
	free_coeffs(nPoly, delay, wet, dry, Az, El, U, V, W);
    } else {
        printf("Memory allocation failed.\n");
    }
    
    return 0;
}
#endif

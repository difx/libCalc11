#define CALC_POLY_ORDER 5

void calcinit();
void dinitl();

int load_ant(const char *site_name, const char *ant_axis, double axis_off, double x, double y, double z);
int load_source(const char *src_name, double RA, double Dec);
int load_eop(int mjd, int taiutc, float ut1utc, float xpole, float ypole);
int runcalc(double mjdstart, double *delay, double *U, double *V, double *W, int maxStation);

// Allocate memory for array polynomials

int allocate_coeffs(int nStation, double ***delay, double ***wet, double ***dry, 
                    double ***Az, double ***El, double ***U, double ***V, double ***W);

void free_coeffs(int nStation, double **delay, double **wet, double **dry, 
                 double **Az, double **El, double **U,double **V, double **W);


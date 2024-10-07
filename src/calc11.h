#define CALC_POLY_ORDER 5

void calcinit_c();
void dinitl_c();

int load_ant_c(const char *site_name, const char *ant_axis, double axis_off, double x, double y, double z);
int load_source_c(int nsrc, const char *src_name, double RA, double Dec);
int load_eop_c(int mjd, int taiutc, float ut1utc, float xpole, float ypole);
void runcalc_c(double mjdstart, double mjdstop);
int runcalc2_c(double mjdstart, double mjdstop, double *delay, int maxStation);

// Allocate memory for array polynomials

int allocate_coeffs(int nStation, double ***delay, double ***wet, double ***dry, 
                    double ***Az, double ***El, double ***U, double ***V, double ***W);

void free_coeffs(int nStation, double **delay, double **wet, double **dry, 
                 double **Az, double **El, double **U,double **V, double **W);


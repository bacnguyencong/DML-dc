#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <memory.h>
#include <time.h>
#include "mex.h"

#define EXACTINPUTS  2
#define EXACTOUTPUTS 2

typedef double *   R_VEC;
typedef int    *   I_VEC;

/* Input Arguments */
#define	INPUT_Y         prhs[0] /* labels */
#define INPUT_D         prhs[1] /* distances  */

/* Output Arguments */
#define	OUTPUT_D    	plhs[0] /* distances*/
#define	OUTPUT_I    	plhs[1] /* indices */

/*------------------------------------------------------------------------*/
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray*prhs[] )
{
    R_VEC pD, pDout;     
    I_VEC pY, pIout;
    int n;
    register int i, j;

    if (nrhs != EXACTINPUTS) {
        mexPrintf("Check input parameters\n");    
        return;
    }
    
    /* get inputs */    
    pY     = (I_VEC) mxGetPr(INPUT_Y);
    pD     = (R_VEC) mxGetPr(INPUT_D);    
    n      = mxGetN(INPUT_D);
    
    /* build output configure */
    OUTPUT_I = mxCreateNumericMatrix(2, n, mxINT32_CLASS, mxREAL);
    OUTPUT_D = mxCreateDoubleMatrix(2, n, mxREAL);
    pDout  = (R_VEC)mxGetPr(OUTPUT_D);
    pIout  = (I_VEC)mxGetPr(OUTPUT_I);
    
    for (j = 0; j < n; ++ j){
        pDout[2*j] = pDout[2*j+1] = 1e99;
        for (i = 0; i < n; ++ i){
            if (i == j) continue;
            if (pY[i] == pY[j] && pD[i + j*n] < pDout[2*j]){
                 pDout[2*j] = pD[i + j*n];
                 pIout[2*j] = i + 1;
            }
            if (pY[i] != pY[j] && pD[i + j*n] < pDout[2*j+1]){
                 pDout[2*j+1] = pD[i + j*n];
                 pIout[2*j+1] = i + 1;
            }
        }
    }    
}
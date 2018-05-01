/*
 * =============================================================
 * FOD.c 
  
 * input: X, a, b, w
 *    X : matrix d x n (double)
 *    a : vector 1 x m (int)
 *    b : vector 1 x m (int)
 *    w : vector 1 x m weight (double)
 *
 * output: for i=1:m; res=res+w(i)*x(:,a(i))*x(:,b(i))';end;
 * 
 * =============================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <memory.h>
#include <time.h>
#include "mex.h"

typedef double *   R_VEC;
typedef int    *   I_VEC;

/* Input Arguments */
#define	INPUT_X         prhs[0] /* input examples */
#define INPUT_a         prhs[1] /* indices of the first element  */
#define	INPUT_b         prhs[2] /* indices of the second element  */
#define	INPUT_w         prhs[3] /* weights */

/* Output Arguments */
#define	OUTPUT_O    	plhs[0] /* outer product*/

/*------------------------------------------------------------------------*/
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray*prhs[] )
{
    R_VEC pX, pw, pO, dummy;
    I_VEC pa, pb;
    
    int m, inda, indb, d;
    double w;
    register int i, j, r, c;
    
    /* get inputs */    
    pX = (R_VEC) mxGetPr(INPUT_X);
    pa = (I_VEC) mxGetPr(INPUT_a);
    pb = (I_VEC) mxGetPr(INPUT_b);    
    if (nrhs > 3)  pw = (R_VEC) mxGetPr(INPUT_w);
    d  = mxGetM(INPUT_X);
    m  = mxGetNumberOfElements(INPUT_a);
    
    if (m != (int)mxGetNumberOfElements(INPUT_b)){
        mexErrMsgTxt("Index should be the same length\n");
        return;
    }        

    /* build output configure */    
    OUTPUT_O = mxCreateDoubleMatrix(d, d, mxREAL);
    pO  = (R_VEC) mxGetPr(OUTPUT_O);
    
    memset(pO,0,sizeof(double)*d*d);    
    dummy = (R_VEC) malloc(d * sizeof(double));
    
    for (i = 0; i < m; ++ i){
        inda = pa[i] - 1; indb = pb[i] - 1;
        for (j = 0; j < d; ++ j)
            dummy[j] = (pX[inda*d + j] - pX[indb*d + j]);
        
        w = (nrhs > 3) ? pw[i]:1;        
        for(j = 0, r = 0; r < d; ++ r){
           for(c = 0; c <= r; ++ c, ++ j)
              pO[j]+=dummy[r]*dummy[c]*w;
           j += d - r - 1;
        }
    }
    
    if (m)
        for( r = 0; r < d; ++ r)
            for(c = r + 1; c < d; ++ c) pO[c + r*d]=pO[r + c*d];
        
    free(dummy);
}


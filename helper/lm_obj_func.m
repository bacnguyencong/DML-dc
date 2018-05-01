function fval = lm_obj_func(M, lambda, s, XTr, YTr)
%% compute the large-margin objective function value and its subgradient at x0
% INPUT:
%   x0: (m x 1) the considered point
%   lambda: the hyper-parameter
%   s: (s < 1) a parameter for the Ramp loss function
%   XTr: (d x n) the input examples
%   YTr: (n x 1) the class labels
% OUTPUT:
%   fval: the objective function value
% =========================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : November 6, 2016
% =========================================================================
   
    % compute all distances
    Dist = sqrt(sMDist(XTr, M));
    DN = get_hits_miss(YTr, Dist);    
    % compute the objective function value    
    fval = lambda*trace(M) + 1/size(XTr,2)*sum(min(1-s,max(1-DN(2,:)+DN(1,:),0)));
end
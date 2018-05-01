function [fval, grad] = G_func(L, lambda, X, U, Hs, Ms)
%% compute the function value of 
%     G = lambda*trace(L*L') + sum(max(1 + h_i, g_i)) - <L*L',U>at L
% INPUT:
%   L: (d x m) the considered point
%   lambda: the hyper-parameter
%   X: (d x n) the input examples
%   Hs: (nn x n) a set of nearest hits
%   Ms: (nn x n) a set of nearest miss
%   U: (d x d) the matrix U
% OUTPUT:
%   fval: the function value
%   grad: the subgradient
% =========================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : November 6, 2016
% =========================================================================
    if (nargout == 2),
        [fval, grad] = H_func(L,1,X,Hs,Ms);
        grad = lambda*eye(size(L,1)) + grad - U;
    else
        fval = H_func(L,1,X,Hs,Ms);
    end
    fval = lambda*trace(L*L') + fval - sum(sum((L*L').*U));
end
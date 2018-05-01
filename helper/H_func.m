function [fval, grad, fval1] = H_func(L, s, X, Hs, Ms)
%% compute the function value of sum(max(s + h_i, g_i)) at L
% INPUT:
%   L: (d x m) the considered point
%   s: parameter s for the ramp loss function
%   X (d x n): the input examples
%   Hs (nn x n): a set of nearest hits
%   Ms (nn x n): a set of nearest miss
% OUTPUT:
%   fval: the function value
%   grad: the subgradient
%   fval1: the function value at s=1
% =========================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : November 6, 2016
% =========================================================================

    % compute nearest hits and misses    
    DN = zeros(2, size(X,2));
    IN = zeros(2, size(X,2));
    
    [IN(1,:), DN(1,:)] = get_min_dist(L'*X, Hs);
    [IN(2,:), DN(2,:)] = get_min_dist(L'*X, Ms);
    
    [V, ind] = max([-DN(1,:); s-DN(2,:)], [], 1);
    % objective funtion value
    fval = 1/size(X,2)*sum(V);
    % computing gradient    
    if (nargout > 1),
        fval1 = 1/size(X,2)*sum(max([-DN(1,:); 1-DN(2,:)], [], 1));
        grad = zeros(size(L,1));  %gradient
        for i=1:2,
            act  = (DN(i,:) > 1e-6) & (ind==i);
            grad = grad - FOP(X,find(act),IN(i,act),1./(2.0*DN(i,act)));
        end
        grad = 1/size(X,2)*grad;
    end
end

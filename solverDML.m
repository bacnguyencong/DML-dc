function M = solverDML(lambda, s, X, Y, nn)
%% Distance metric learning using DCA
% INPUT:
%   lambda: the hyper-parameter
%   s: parameter s for the ramp loss function
%   X: the input examples
%   Y: the class labels
%   nn: number of examples to keep in miss and hit sets
% OUTPUT:
%   x: the Mahalanobis matrix
% =========================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : November 6, 2016
% =========================================================================    
    options.optTol      = 1e-6;
    options.MaxFunEvals = 1000;
    options.max_iter    = 20;
    options.Display     = 'off';
    if nargin < 5,
        nn = 10;
    end
    M = dca(eye(size(X,1)), options, lambda, s, X, Y, nn);    
end
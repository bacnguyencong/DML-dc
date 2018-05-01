function M = dca(L, options, lambda, s, X, Y, nn)
%% Distance metric learning using DCA
% INPUT:
%   L: initial solution
%   options:
%       MaxFunEvals: maximum number of iterations
%       max_iter: maximum number of iteration on DCA
%       optTol: tolerance
%       Display: 'off' 
%   lambda: the hyper-parameter
%   s: (s < 1) the parameter for Ramp loss function
%   X: (d x n) the input examples
%   Y: (n x 1) the class labels
%   nn: number of examples to keep in miss and hit sets
% OUTPUT:
%   M: the Mahalanobis matrix
% =========================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : November 6, 2016
% =========================================================================
    quiet = strcmp(options.Display,'off');
    if ~quiet,
        fprintf('-----------------------------------------------------\n');
        fprintf('%6s %15s %15s %14s\n', '#iter', 'G(x)', 'H(x)', ' F(x)');
        fprintf('-----------------------------------------------------\n');
    end
    best = Inf;
    M = L*L';
    % start optimizing
    for iter=1:options.max_iter,        
        %update sets of hit and mit examples
        [Hs, Ms] = get_hit_mit_sets(L'*X, Y, nn, nn);
        
        % linearizing the first part
        [valH, grad, valG] = H_func(L, s, X, Hs, Ms);
        valG = valG + lambda*(L(:)'*L(:));
        % saving the Mahalanobis matrix
        if (valG - valH < best)
            M = L*L';
            best = valG - valH;
        end
        if ~quiet,            
            fprintf('%6d %15.5f %15.5f %14.5f\n',iter,valG,valH,valG-valH);
        end
        
        % optimizing the convex part
        prevL = L;
        L = subgrad_descent(options, X, Y, L, lambda, grad, Hs, Ms);
        
        % found a good solution
        if (norm(prevL*prevL'-L*L', 'fro') < options.optTol),
            break;
        end
    end
end

function [best_L, best_C] = subgrad_descent(options, X, Y, L, lambda, U, Hs, Ms)
% ==================================================================
% Perform sub-gradient descent method
% 
% INPUT 
%       options: optimization options
%       X: (d x n) the input examples
%       Y: (n x 1) the class labels
%       L: (d x m) the initial solution
%       lambda: the hyper-parameter
%       U (d x d): the subgradient of H
%       Hs (nn x n): a set of nearest hits
%       Ms (nn x n): a set of nearest miss
% OUTPUT 
%       best_L: (d x m) the optimal solution
%       best_C: the minimum value of objective function
% =================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : April 6, 2017
% =================================================================

    if nargin < 3,
        options = [];
    end
    
    if ~isfield(options, 'min_iter')
        options.min_iter = 50;      % minimum number of iterations        
    end
    if ~isfield(options, 'eta')
        options.eta = 0.001;         % step size    
    end
    if ~isfield(options, 'tol')
        options.optTol = 1e-6;      % tolerante
    end
    if ~isfield(options, 'MaxFunEvals')
        options.MaxFunEvals = 1000; % maximum number of iterations
    end
    if ~isfield(options, 'Display')
        options.Display = 'off';    % show ouput
    end

    [C, grad] = G_func(L, lambda, X, U, Hs, Ms);
    best_L = L;
    best_C = C;
    prev_C = Inf;
    
    iter = 1;
    quiet = 1;
    check_point = 100;
    
    while (abs(prev_C - C) > options.optTol || iter < options.min_iter) ...
                    && (iter < options.MaxFunEvals)
        prev_C = C;
        [~, L] = kk_proj(L*L' - options.eta*grad); 
        if isempty(L), break; end        
        if mod(iter,check_point) == 0,
            [Hs, Ms] = get_hit_mit_sets(L'*X, Y, size(Hs,1), size(Ms,1));
        end
        [C, grad] = G_func(L, lambda, X, U, Hs, Ms);        
        if ~quiet && mod(iter, 100)==0,
            fprintf('#iter=%d, Obj=%.6f\n', iter, C); 
        end
        if (C < prev_C)
            options.eta = options.eta * 1.01;
        else
            options.eta = options.eta * .5;
        end        
        if C < best_C,
            best_C = C;
            best_L = L;
        end
        iter = iter + 1;
    end
end

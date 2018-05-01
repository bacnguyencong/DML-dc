function [DN, IN] = get_hits_miss(labels, Dist)    
%%%%%%%% need to be improved
%% Compute nearest hit and nearest miss for each examples
% INPUT:
%   Y:    (n x 1) class labels
%   Dist: (n x n) the distance matrix for all pairs of examples
% OUTPUT:
%   DN: (2 x n) distances to nearest hits (1,:) misses (2,:)
%   IN: (2 x n) indices to nearest hits (2,:) and misses (2,:)
% =================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : April 6, 2017
% =================================================================
    [DN, IN] = mex_get_hits_miss(int32(labels), Dist); IN = double(IN);
end
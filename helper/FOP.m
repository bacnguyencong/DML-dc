function D = FOP(X, a, b, w)
%  Fast compute the sum of all outer products
%  INPUT:
%    X : matrix d x n (double)
%    a : vector 1 x m (int)
%    b : vector 1 x m (int)
%    w : vector 1 x m weight (double)
%
%  OUTPUT: for i=1:m; D=D+w(i)*x(:,a(i))*x(:,b(i))';end;
% =========================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : November 6, 2017
% =========================================================================
    if nargin > 3,
        D = mex_FOP(double(X), int32(a), int32(b), double(w));
    else
        D = mex_FOP(double(X), int32(a), int32(b));
    end
end


function Dist = sMDist(XTr, M)
    X = sum(XTr.*(M*XTr), 1)';
    % compute all distances
    Dist = bsxfun(@plus, X, bsxfun(@plus, X', -2*XTr'*(M*XTr)));
end
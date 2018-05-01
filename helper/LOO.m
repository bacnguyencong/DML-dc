function acc = LOO(XTr, YTr, M)
    labels = kNearestNeighbors(XTr,XTr,2,M);
    labels = YTr(labels(2,:));
    acc    = mean(labels == YTr) * 100;
end
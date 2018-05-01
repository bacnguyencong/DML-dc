function M = autoLearnDML(XTr, YTr)
    best_acc = -Inf;
    rng(123456);
    COV = cvpartition(YTr,'HoldOut',0.2);
    % do grid search
    fprintf('------------------------------------\n');
    fprintf('%2s %9s %6s\n', 's', 'lambda', 'Acc');
    fprintf('------------------------------------\n');
    for s = -1,
        for l = 10.^(-3:0),
            M = solverDML(l, s, XTr(:,COV.training), YTr(COV.training));
            preds = knnClassifier(XTr(:,COV.training),YTr(COV.training),1,XTr(:,COV.test),M);
            acc = mean(YTr(COV.test) == preds) * 100;
            if (acc > best_acc),
                best_acc = acc;
                best_s = s;
                best_l = l;
            end
            fprintf('%2d %9.3f %6.2f\n',s,l,acc);
        end
    end    
    fprintf('------------------------------------\n');
    M = solverDML(best_l, best_s, XTr, YTr);
end
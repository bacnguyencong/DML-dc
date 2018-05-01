function preds = knnClassifier(XTr, YTr, k, XTe, M)
%%=========================================================================
% k nearest neighbors classifier
% INPUT:
%       XTr     : training examples by columns   
%       YTr     : class label of input examples by column vector
%       k       : number of nearest neighbors
%       XTe     : testing examples by columns
%       M       : the Mahalanobis distance metric
% OUPUT:
%       preds   :  predicted label for each instance in XTe by colums
%==========================================================================
% author: Bac Nguyen Cong 
% email : nguyencongbacbk@gmail.com
%%=========================================================================

    inds  = kNearestNeighbors(XTr, XTe, k, M);
    preds = YTr(inds);
    if size(inds, 1) > 1  %check if is 1 nearest neighbor classifier
        preds = mode(preds, 1);
    end    
    preds = preds(:);
end
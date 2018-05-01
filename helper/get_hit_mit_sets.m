function [Hs, Ms] = get_hit_mit_sets(xTr, yTr, n_hit, n_mis)    
    n = size(xTr, 2);
    l = unique(yTr);
    
    Hs = zeros(n_hit, n); % hits for training
    Ms = zeros(n_mis, n); % miss for training
    
    for i=1:length(l),
        %fprintf('Find hits and miss for class (%d)...\n', i);
        same = xTr(:, yTr == l(i));
        dife = xTr(:, yTr ~= l(i));
        
        idx_same = find(yTr == l(i));
        idx_diff = find(yTr ~= l(i));
        
        iknn = kNearestNeighbors(same, same, n_hit+1);                
        kknn = kNearestNeighbors(dife, same, n_mis);
        
        Hs(:,idx_same)= idx_same(iknn(2:n_hit+1,:));
        Ms(:,idx_same)= idx_diff(kknn);
    end
end


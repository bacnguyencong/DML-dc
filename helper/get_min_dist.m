function[idx, Dist] = get_min_dist(xTr, T)
    idx  = T(1,:);
    Dist = distance(xTr,T(1,:));
    for i=2:size(T, 1),
        dist = distance(xTr, T(i,:));
        active = dist < Dist;
        idx(active) = T(i, active);
        Dist(active) = dist(active);
    end
end

function Dist = distance(xTr, first)
    Dist = sqrt(sum((xTr - xTr(:,first)).^2, 1));
end
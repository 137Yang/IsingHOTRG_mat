function [T] = update(T,gauge)
T = ncon({gauge,T,T,gauge},{[1,3,-1],[1,2,-3,5],[3,4,5,-4],[2,4,-2]});
% T = T ./ norm(T(:));
% T = T ./ max(abs(T(:)));
end
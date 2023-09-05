function [Z,err] = coarsegrain(bt,chi,N,L,g)
% 没问题
% N: steps of contractction of two local tensors
% L: number of site
n = log2(N);
[T] = get_MPO(g,bt,N);
for i = 1:n
    [gauge,err] = getgauge(T,chi);
    T = update(T,gauge);
end
% partial trace of updated tensor
p = ncon({T},{[-1,-2,1,1]});
Z = trace(p^L);
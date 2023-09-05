function [gauge,err]=getgauge(T,chi)
% 
% [T] = get_MPO(0.1,0.1); chi = 20;
dT = size(T);
MM = ncon({T,T},{[-1,-3,-5,1],[-2,-4,1,-6]});
d = size(MM);
M = reshape(MM,d(1)*d(2),d(3)*d(4),d(5),d(6));
d = size(M);

ML = reshape(M,[d(1),d(2)*d(3)*d(4)]);
ML = ML*ML';
ML = 0.5*(ML+ML');
ML = real(ML);
[UL,L,~] = svd(ML);
L = diag(L);
errL = norm(L(chi+1:end))/norm(L);

MR = permute(M,[2,1,3,4]);
dr = size(MR);
MR = reshape(MR,[dr(1),dr(2)*dr(3)*dr(4)]);
MR = MR*MR';
MR = 0.5*(MR+MR');
MR = real(MR);
[UR,R,~] = svd(MR);
R = diag(R);
errR = norm(R(chi+1:end))/norm(R);

if errL<=errR
    err = errL;
    UL(:,chi+1:end) = [];
    gauge=UL;
    chi=min(chi,dT(1)*dT(1));
    gauge=reshape(gauge,[dT(1),dT(1),chi]);
    % gauge = gauge ./ norm(gauge(:));
else
    err = errR;
    UR(:,chi+1:end) = [];
    gauge=UR;
    chi=min(chi,dT(2)*dT(2));
    gauge=reshape(gauge,[dT(2),dT(2),chi]);
    % gauge = gauge ./ norm(gauge(:));
end

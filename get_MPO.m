function [T] = get_MPO(g,bt,N)
% 复数没问题
% define a local Hamiltonian
%test function
% g = 0.5;tau=0.1;

sX = [0,1;1,0]; 
sZ = [1,0;0,-1]; sI = [1,0;0,1];
J = 1;
hlocal = J * (-kron(sZ,sZ) - g*kron(sX,sI));

% exponentiate the Hamiltonian
d = 2;
% tau = 0.1; % set time-step  tau = beta/N
gateAB = reshape(expm(-bt./N*hlocal),[d,d,d,d]);
gateBA = reshape(expm(-bt./N*hlocal),[d,d,d,d]);

% gate --> MPO TA,TB
gateABp = permute(gateAB,[1,3,2,4]);
[uAB,sAB,vAB] = svd(reshape(gateABp,[d^2,d^2])); % divide steps
gateBAp = permute(gateBA,[1,3,2,4]);
[uBA,sBA,vBA] = svd(reshape(gateBAp,[d^2,d^2]));

ABa = reshape(uAB * sqrt(sAB), [d,d,d^2]);
ABb = reshape(sqrt(sAB) * vAB', [d^2,d,d]);
BAa = reshape(sqrt(sBA) * vBA', [d^2,d,d]);
BAb = reshape(uBA * sqrt(sBA), [d,d,d^2]);

TA = ncon({BAa,ABa},{[-1,-3,1],[1,-4,-2]});
TB = ncon({ABb,BAb},{[-1,1,-4],[-3,1,-2]});


Tp = ncon({TA,TB},{[-1,1,-3,-5],[1,-2,-4,-6]});
d = size(Tp);
T = reshape(Tp,[d(1),d(2),d(3)*d(4),d(5)*d(6)]);
end
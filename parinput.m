function [chi,N,L,gi,btR,btI] = parinput
btR = 0.1:0.1:0.1; btI = 0.1:0.1:0.1; 
% [R,I] = meshgrid(btR,btI);
% bt = R + I*1i;
chi = 10; % 10 or larger 
nstep = 10; % N = 2^n
N = 2^nstep;
nsite = 64; % 先只做2,4
L = nsite/2; % from small to large
gi = 1:2:1;


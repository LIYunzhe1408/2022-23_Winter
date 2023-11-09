% Operational Research
% @author 李昀哲 20123101
% Feb 25, 2023
syms x1 x2


% 目标函数
fxstar=(x1-2)^2+(x2-1)^2;
% 约束条件
g=[-0.25*x1^2-x2^2+1];
h=[x1-2*x2+1];

% 初始点和epsilon
x0=[2 2];
eps=1e-3;

[xstar,fxstar, iter]=penalty(fxstar,g,h,x0,eps)

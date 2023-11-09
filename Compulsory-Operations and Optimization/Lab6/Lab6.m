% Operational Research
% @author 李昀哲 20123101
% Jan 5, 2023
A = [-1 3 1 0; 7 1 0 1];
b = [6; 35];
c = [-7; -9;0;0];%标准格式是求min

lb = [0; 0;0;0]; %x值的初始范围下界
ub=[inf;inf;inf;inf];%x值的初始范围上界

optX = [0; 0];
optVal = 0;
[xstar, fxstar] = BranchBound(A, b, c, [], [], lb, ub, optX, optVal, 0)
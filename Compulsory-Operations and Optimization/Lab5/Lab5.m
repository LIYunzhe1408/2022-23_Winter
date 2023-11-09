% Operational Research
% @author 李昀哲 20123101
% Dec 28, 2022
%% 数据准备
A = [-1 3 1 0; 7 1 0 1]; 
b = [6 35]'; 
c = [7 9 0 0];

%% 函数调用
[xstar,fxstar,iter] = Gomory(A,b,c)
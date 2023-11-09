% Operational Research
% @author 李昀哲 20123101
% Dec 27, 2022
%% 数据准备
A=[-1,-2,-1,1,0;
    -2,1,-3,0,1];
b=[-3,-4]';
c=[-2,-3,-4,0,0]';
format rat;

%% 函数调用
[x_opt,fx_opt,iter]=DSimplex_eye(A,b,c);
x_opt, fx_opt, iter
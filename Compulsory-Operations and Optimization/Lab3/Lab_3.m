% Operational Research
% @author 李昀哲 20123101
% Dec 17, 2022
A=[2,-3,2,1,0;
    1/3,1,5,0,1];
b=[15,20]';
c=[1,2,1,0,0];

format rat; % 保留分数格式，而非小数
[x_opt,fx_opt,iter] = Simplex_eye(A,b,c);
x_opt
fx_opt
iter
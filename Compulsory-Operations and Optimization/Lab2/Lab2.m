% Operational Research
% @author 李昀哲 20123101
% Dec 14, 2022
% 给出LP问题基本可行解及其对应的基
A=[2,1,1,0,0;
   1,1,0,1,0;
   0,1,0,0,1;];
b=[10,8,7]';

[xs,Bs,x_num]=BFS(A,b)
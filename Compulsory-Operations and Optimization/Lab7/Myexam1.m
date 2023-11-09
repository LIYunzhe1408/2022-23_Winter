% Operational Research
% @author 李昀哲 20123101
% Feb 20, 2023
function [f,g]=Myexam1(x)     
%%%%调用[f,g] = feval(f_name,xk);
f=x(1)^2+2*x(2)^2; 
g=[2*x(1);4*x(2)];
end
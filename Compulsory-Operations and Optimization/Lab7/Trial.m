% Operational Research
% @author 李昀哲 20123101
% Feb 20, 2023
function [b] = Trial(f_k,xk,dk,a0,h0,eps)
%确定区间右端点
f0 = feval(f_k,xk+a0*dk);% 计算初始点函数值
a1 = a0 + h0;
f1 = feval(f_k,xk+a1*dk);
%防止数值误差引起的错误，加入约束条件abs(f1-f0)>eps
while abs(f1-f0)<eps
    a1 = a1 + h0;
    f1 = feval(f_k,xk+a1*dk);
end
b=a1;
%让a1等长度增加，h0=0.1，如果找到f1>f0，退出
while f1<=f0
    a1=a1+ h0;
    f1=feval(f_k,xk+a1*dk);
end
b=a1;
end
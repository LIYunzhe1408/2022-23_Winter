% Operational Research
% @author 李昀哲 20123101
% Feb 25, 2023
function [xstar,fxstar, iter]=penalty(penalty_func,constrains,h,x0,eps)
% f 目标函数
% g 不等式约束函数矩阵
% h 等式约束函数矩阵
% x0 初始值
% eps 退出容差
M=0.01;% M 初始惩罚因子
C=3;% C 罚因子放大倍数
penalty = sum(h.^2);
iter = 1;
while iter
    % 判断在不在可行域内
    gx=double(subs(constrains,symvar(constrains),x0));
    index=find(gx<0);
    F_NEQ=sum(constrains(index).^2);
    F=matlabFunction(penalty_func+M*F_NEQ+M*penalty);
    x1=Min_Newton(F,x0,eps,100);
    x1=x1'
    if norm(x1-x0)<eps
        xstar=x1;
        fxstar=double(subs(penalty_func,symvar(penalty_func),xstar));
        break;
    else
        M=M*C;
        x0=x1;
    end
    iter=iter+1;
end
end


% Operational Research
% @author 李昀哲 20123101
% Feb 25, 2023
function [X,result]=Min_Newton(f,x0,eps,n)
%f为目标函数
%x0为初始点
%eps为迭代精度
%n为迭代次数

% 求梯度和hessian矩阵
grad = gradient(sym(f),symvar(sym(f)));
Hessian=jacobian(grad,symvar(sym(f)));
Var_grad=symvar(grad);
Var_Hessian=symvar(Hessian);
Var_Num_grad=length(Var_grad);
Var_Num_Hessian=length(Var_Hessian);
grad=matlabFunction(grad);
flag = 0;
if Var_Num_Hessian == 0  % 判断hessian矩阵是常数
    Hessian=double((Hessian));
    flag=1;
end
% 求当前点梯度与hessian矩阵的逆
f_cal='f(';
Grad_cal='TiDu(';
Hessian_cal='Haisai(';
for k=1:length(x0)
    f_cal=[f_cal,'x0(',num2str(k),'),'];
    
    for j=1: Var_Num_grad
        if char(Var_grad(j)) == ['x',num2str(k)]
            Grad_cal=[Grad_cal,'x0(',num2str(k),'),'];
        end
    end
    
    for j=1:Var_Num_Hessian
        if char(Var_Hessian(j)) == ['x',num2str(k)]
            Hessian_cal=[Hessian_cal,'x0(',num2str(k),'),'];
        end
    end
end
Hessian_cal(end)=')';
Grad_cal(end)=')';
f_cal(end)=')';
switch flag
    case 0
        Hessian=matlabFunction(Hessian);
        dk='-eval(Hessian_cal)^(-1)*eval(Grad_cal)';
    case 1
        dk='-Hessian^(-1)*eval(Grad_cal)';
        Hessian_cal='Hessian';
end
i=1;
while i < n 
    if abs(det(eval(Hessian_cal))) < 1e-6
        disp('逆矩阵不存在！');
        break;
    end
    x0=x0(:)+eval(dk);
    if norm(eval(Grad_cal)) < eps
        X=x0;
        result=eval(f_cal);
        return;
    end
    i=i+1;
end
disp('无法收敛！');
X=[];
result=[];
end
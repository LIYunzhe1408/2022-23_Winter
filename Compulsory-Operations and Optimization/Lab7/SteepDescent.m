% Operational Research
% @author 李昀哲 20123101
% Feb 20, 2023
function [xstar,fxstar,iter] = SteepDescent(f_name,x0,eps)
iter=0;           % 初始化迭代次数
[~,g]=Myexam1(x0);% 求导，计算初始梯度
x=x0;
dk=-g;            % 初始搜索方向为当前梯度的反方向
while norm(g)>eps % 未达到终止精度要求
    iter=iter+1;

    [b] = Trial(@Myexam1,x,dk,1,0.1,eps);  % 确定搜索区间，左端为0，只需计算出右端b,a0取1，h取0.1
    [lamda]=S618(@Myexam1,x,dk,[0,b],eps); % 0.618搜索
    
    % 区间参数迭代
    x_0=x;
    x=x_0+lamda*dk;
    [~,g]=Myexam1(x);  % 每轮迭代计算梯度
    dk=-g; 
    s1 =sqrt((x - x_0)'*(x - x_0));
    if s1 <= eps
        break;
    end
end
xstar=x;
[fxstar,~]=Myexam1(xstar);
end
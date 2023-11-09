function [x_opt,fx_opt,A,b] = simplex_back_up(A,b,c)
[m,n] = size(A);              %m约束条件个数, n决策变量数
ind_B =has_ones(A);
ind_N = setdiff(1:n, ind_B);  %非基变量的索引,原理是返回在1:n中出现而不在ind_B即基变量索引中出现的元素，并从小到大排序
% 循环求解
while true
    x0 = zeros(n,1);
    x0(ind_B) = b;               %初始基可行解，令基变量的位置为方程组右边系数，非基变量取值为0
    cB = c(ind_B);               %计算cB，即目标函数在基变量处对应的系数
    Sigma = zeros(1,n);          %Sigma为检验数向量
    Sigma(ind_N) = c(ind_N) - cB*A(:,ind_N);   %计算检验数（非基变量），因为基变量对应的初始检验数一定为0
    [~, k] = max(Sigma);         %选出最大检验数, 确定进基变量索引k；~表示忽略第一个参数（即最大值），k是索引
    if ~any(Sigma > 0)           %所有检验数都小于0，此基可行解为最优解, any表示存在某个检验数>0        
        x_opt = x0;
        fx_opt = c * x_opt;      %算出最优解
        return
    end
    if all(A(:,k) <= 0)          %表示检验数这一列每个数都<=0，有无界解
        x_opt = [];
        break
    end
    Theta = b ./ A(:,k);         %计算θ（点除，即矩阵中对应元素相除，得到一个新的矩阵）
    Theta(Theta<=0) = 10000;
    [~, q] = min(Theta);         %选出最小θ
    el = ind_B(q);               %确定出基变量在系数矩阵中的列索引el, 主元为A(q,k)
    % 换基
    ind_B(ind_B == el) = k;      %新的基变量索引
    ind_N = setdiff(1:n, ind_B); %非基变量索引
    % 更新A和b
    A(:,ind_N) = A(:,ind_B) \ A(:,ind_N); %基矩阵的逆乘以非基矩阵
    b = A(:,ind_B) \ b;  %基矩阵的逆乘以b
    A(:,ind_B) = eye(m,m);  %基矩阵更新为单位矩阵
end
end
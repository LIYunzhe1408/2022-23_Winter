function [x_opt,fx_opt,A,b] = DSimplex_eye_backup(A,b,c)
% 对偶单纯形法求解标准形线性规划问题: max cx s.t. Ax = b x>=0
% 输入参数: c为目标函数系数, A为约束方程组系数矩阵, b为约束方程组常数项
% 输出参数: x_opt为最求解，fx_opt为最优函数值，iter为迭代次数
format rat                    %元素使用分数表示
[m,n] = size(A);              %m约束条件个数, n决策变量数
ind_B = has_ones(A);
ind_N = setdiff(1:n, ind_B);  %非基变量的索引,原理是返回在1:n中出现而不在ind_B即基变量索引中出现的元素，并从小到大排序
while true
    x0 = zeros(n,1);
    x0(ind_B) = b;                %初始基可行解
    cB = c(ind_B);                %计算cB
    if ~any(b < 0)                %此基可行解为最优解, any存在某个<0        
        x_opt = x0;
        fx_opt = c*x_opt;
        return
    end
    index=find(b<0);
    for i = 1:numel(index)
        if all(A(index(i),:)>=0)
            x_opt=[];
            fx_opt = [];         %此时原问题无可行解，对偶问题存在无界解
            return
        end
    end
    Sigma = zeros(1,n);
    Sigma(ind_N) = c(ind_N) - cB*A(:,ind_N);   %计算检验数
    [~,q] = min(b);               %选出最小的b
    r = ind_B(q);                 %确定出基变量索引r
    Theta = Sigma ./ A(q,:);      %计算θ
    Theta(Theta<=0) = 10000;
    [~,s] = min(Theta);           %确定进基变量索引s, 主元为A(q,s)
    % 换基
    ind_B(ind_B == r) = s;        %新的基变量索引
    ind_N = setdiff(1:n, ind_B);  %非基变量索引
    % 更新A和b
    A(:,ind_N) = A(:,ind_B) \ A(:,ind_N);
    b = A(:,ind_B) \ b;
    A(:,ind_B) = eye(m,m);
end
end
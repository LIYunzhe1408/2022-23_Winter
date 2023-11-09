% Operational Research
% @author 李昀哲 20123101
% Dec 17, 2022
function [x_opt,fx_opt,iter] = Simplex_eye(A,b,c)
% 格式、容器准备
format rat 
[m,n] = size(A)
index_B = [];
iter = 0;                          
%% 遍历所有列的组合，找单位阵。方法类似实验一
% A的列随机组合
randIndex = randperm(size(A,2));

% 随机组合后的集合
C = nchoosek(randIndex,m);      
for i=1:size(C,1)
    if (A(:,C(i,:))== eye(m,m))
        %找到单位矩阵
        disp("----Eye Found----");
        % 将找到的单位阵的序号append入list中。
        index_B = C(i,:);
    end
end
% 将非基变量从小到大排序
index_Not_basic_variable = setdiff(1:n, index_B);

%% 开始循环迭代
while(true)
    disp("----------------------------------------------------------");
    %fprintf("\t\t%d iter", iter+1);
    % 取基变量，非基变量取值为0
    x0 = zeros(n,1);
    x0(index_B) = b;% 
    check_Coefficient = c(index_B);
    coefficient_Not_basic_variable = c(index_Not_basic_variable)

    %基本矩阵
    B = A(:,index_B)
    not_basic_variable_mat = A(:,index_Not_basic_variable)

    % 系数-基变量系数*A中元素
    to_be_minus = (check_Coefficient)*inv(B)*not_basic_variable_mat;
    check_num_seq = coefficient_Not_basic_variable-to_be_minus;
    check_num_seq
    
    % 找到检验数最大的值和索引
    [value index] = max(check_num_seq);
    k=index;

    %% 判断迭代是否结束
    % 检验数是否都小于等于零
    if all(check_num_seq(:)<=0)
        x_opt = x0;
        fx_opt = c*x_opt;
        return
    end
    % 判断是否无界
    temp = inv(B)*not_basic_variable_mat;
    if all(temp(:)<=0)
        x_opt = [];
        fx_opt = [];
        disp('问题无界')
        return
    end
    %% 换基
    % 选一个基变量作为换出变量
    to_be_transfer_IN = A(:,k)
    yk = inv(B)*to_be_transfer_IN;
    
    % 计算theta确定换出哪一个
    theta = b./yk;
    theta(theta<=0) = 10000;
    [~,minIndex] = min(theta);
    r = index_B(minIndex);
    
    % 换基操作
    index_B(index_B == r) = k;        
    % 重新排序
    index_Not_basic_variable = setdiff(1:n, index_B); 

 
    
    %% 更新A和b
    A(:,index_Not_basic_variable) = A(:,index_B) \ A(:,index_Not_basic_variable);
    b = A(:,index_B) \ b 
    A(:,index_B) = eye(m,m) 
    iter=iter+1;
end
end
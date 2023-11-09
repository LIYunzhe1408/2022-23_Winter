function [xs,Bs,x_num]=BFS(A,b)
%存储基本可行解, 可行基矩阵, 基本可行解个数
xs = [];Bs = {};x_num = 0;

% 一些用到的临时变量
temp = []; 
inv_temp = [];

cnt = 1;

[row,col] = size(A);
m = rank(A);

% 二项式公式，选出所有组合
all_num = nchoosek(col,row);
all_col = nchoosek(1:col,m);
if m < row
    error('无法求解');
else
    for i = 1:all_num
        temp = A(:,all_col(i,:));
        if rank(temp) == m
            inv_temp = inv(temp)*b;
            if inv_temp >= 0
                for j=1:col
                    xs(cnt,j) = 0;
                end
                xs(cnt,all_col(i,:)) = inv_temp;
                Bs{1,cnt} = temp;
                cnt = cnt+1;
            end
        end
    end
    x_num = cnt-1;    
end
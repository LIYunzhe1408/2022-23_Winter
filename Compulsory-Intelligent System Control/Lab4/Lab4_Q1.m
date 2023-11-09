clear all;
close all;

% 题目已知
A = [1;   0.5];
B = [0.1; 0.5; 1];
C = [0.2; 1];

%%
% 根据公式A和B首先进行合成操作
% 其中"与"运算用min函数
% R = (AxB)T · C
for i = 1:2
    for j = 1:3
        AB(i,j) = min(A(i), B(j));
    end
end

% 转置处理，准备和C做合成
column_vec = [];
for i = 1:2
    column_vec = [column_vec;AB(i,:)'];
end

% 确定模糊关系矩阵
for i = 1:6
    for j = 1:2
        R(i, j) = min(column_vec(i), C(j));
    end
end
disp("R = ")
disp(R);
%%
% 计算C1 = (A1 x B1) · R
A1 = [0.8, 0.1];
B1 = [0.5, 0.2, 0];
for i = 1:2
    for j = 1:3
        AB1(i, j) = min(A1(i), B1(j));
    end
end

% 转置，为合成做准备
column_vec_2 = [];
for i = 1:2
    column_vec_2 = [column_vec_2, AB1(i, :)];
end

for i = 1:6
    for j = 1:2
        temp(i, j) = min(column_vec_2(i), R(i, j));
        C1(j) = max(temp(:, j));
    end
end
disp("C1 = ")
disp(C1);

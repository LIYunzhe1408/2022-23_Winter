% Operational Research
% @author 李昀哲 20123101
% Dec 1, 2022
A = [1 2 3; -1 3 7; 9 0 3];
b = [1 4 7]';

x = gauss_elim(A, b);

% 输出答案
for ans_num = 1:size(A,1)
    fprintf("\tx%d = %d\n", ans_num, x(size(A,1)-ans_num+1));
end

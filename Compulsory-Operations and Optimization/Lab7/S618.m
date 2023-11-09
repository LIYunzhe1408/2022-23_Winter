% Operational Research
% @author 李昀哲 20123101
% Feb 20, 2023
function [x] = S618(f_name,xk,dk,range,e)
%0.618搜索确定lamda的极小点
% xk: 当前搜索点
% dk: 当前搜索方向
% e: 精度要求
a = range(1);b = range(2);
flag = 0;%设置一个退出标志
while flag==0
    u = a+0.382*(b-a); 
    v = a+0.618*(b-a);
    m = feval(f_name,xk+u*dk); 
    n = feval(f_name,xk+v*dk);
    if m>n %区间变成[u,b]
        if b-u<e %区间大小满足要求
            x = v; 
            flag = 1;
        else    %更改区间，继续迭代
            a = u;
            flag = 0;
        end
    else  %区间变成[a,v]
        if v-a<e  %区间大小满足要求
            x = u; 
            flag = 1;
        else     %更改区间，继续迭代
            b=v;
            flag = 0;
        end
    end
end
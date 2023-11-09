function [xstar,fxstar,iter] = Gomory(A,b,c)
iter=0;

while true
    [m,n]=size(A);
    if min(b)>=0
        % 单纯形法求解
        [x_opt,fx_opt,CA,Cb] = simplex(A,b,c);
    else
        % 对偶单纯形法求解
        [x_opt,fx_opt,CA,Cb] = DSimplex_eye(A,b,c);
    end
    % 判断是否已经解出了整数最优解
    is_integer=1;
    for pos_x = 1:m
        if abs(round(x_opt(pos_x))-x_opt(pos_x))>=1e-3 % 判断整数条件
            is_integer=0;
            break;
        end
    end
    if is_integer==1           %如果解全是整数，满足条件，循环结束
        xstar=x_opt;
        fxstar=fx_opt;
        break;
    end
    iter=iter+1;
    % 找出b中和整数相差最大的数
    % 循环遍历
    cha=0;
    row=0;
    for r=1:m
        t=abs(floor(x_opt(r))-x_opt(r));
        if t>cha
            cha=t;
            row=r; % 标记当前最大差值的位置
        end
    end
    n=n+1;
    m=m+1;
    iter=iter+1;
    %原基础上增加一行一列，第（m,n）=1
    tmp_A=zeros(m,n);
    tmp_b=zeros(m,1);
    tmp_c=zeros(1,n);
    for i=1:m-1
        for j=1:n-1
            tmp_A(i,j)=CA(i,j);
        end
        tmp_b(i,1)=Cb(i,1);
    end
    tmp_b(m,1)=floor(Cb(row,1))-Cb(row,1);
    tmp_A(m,n)=1;
    for i =1:n-1
        tmp_c(1,i)=c(i);
    end
    % add约束条件
    for i=1:n-1
        if tmp_A(row,i)==0
            tmp_A(m,i)=0;
        else
            tmp_A(m,i)=floor(tmp_A(row,i))-tmp_A(row,i);
        end
    end
    A=tmp_A;
    b=tmp_b;
    c=tmp_c;
end         
end
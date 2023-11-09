function [index]=has_ones(a)  %判断矩阵是否含有单位阵
    [m,n]=size(a);
    b=min(m,n);
    one=eye(b);
    index=[];
    result=zeros(m,1);
    for i =1:n
        for j=1:b
            if a(:,i)==one(:,j)
                index=[index,i];
                break;
            end
        end
    end
    for k=index
        result=result+a(:,k);
    end
    if result ~= ones(m,1)
       index=[];
    end
end
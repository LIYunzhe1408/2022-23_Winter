function [x_opt,fx_opt,A,b] = DSimplex_eye(A,b,c)
[m,n] = size(A);             
ind_B = has_ones(A);
ind_N = setdiff(1:n, ind_B);  
while true
    x0 = zeros(n,1);
    x0(ind_B) = b;               
    cB = c(ind_B);                
    if ~any(b < 0)                      
        x_opt = x0;
        fx_opt = c*x_opt;
        return
    end
    index=find(b<0);
    for i = 1:numel(index)
        if all(A(index(i),:)>=0)
            x_opt=[];
            fx_opt = [];         
            return
        end
    end
    Sigma = zeros(1,n);
    Sigma(ind_N) = c(ind_N) - cB*A(:,ind_N);   
    [~,q] = min(b);              
    r = ind_B(q);                 
    Theta = Sigma ./ A(q,:);      
    Theta(Theta<=0) = 10000;
    [~,s] = min(Theta);           
    % 换基
    ind_B(ind_B == r) = s;       
    ind_N = setdiff(1:n, ind_B); 
    % 更新A和b
    A(:,ind_N) = A(:,ind_B) \ A(:,ind_N);
    b = A(:,ind_B) \ b;
    A(:,ind_B) = eye(m,m);
end
end
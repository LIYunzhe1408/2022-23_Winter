function [x_opt,fx_opt,A,b] = simplex(A,b,c)
[m,n] = size(A);              
ind_B =has_ones(A);
ind_N = setdiff(1:n, ind_B);  


while true
    x0 = zeros(n,1);
    x0(ind_B) = b;               
    cB = c(ind_B);               
    sigma = zeros(1,n);          
    sigma(ind_N) = c(ind_N) - cB*A(:,ind_N);   
    [~, k] = max(sigma);         
    if ~any(sigma > 0)                  
        x_opt = x0;
        fx_opt = c * x_opt;      
        return
    end
    if all(A(:,k) <= 0)          
        x_opt = [];
        break
    end
    theta = b ./ A(:,k);         
    theta(theta<=0) = 10000;
    [~, q] = min(theta);         
    el = ind_B(q);               
    % 换基
    ind_B(ind_B == el) = k;      
    ind_N = setdiff(1:n, ind_B); 
    % 更新A和b
    A(:,ind_N) = A(:,ind_B) \ A(:,ind_N); 
    b = A(:,ind_B) \ b; 
    A(:,ind_B) = eye(m,m);  
end
end
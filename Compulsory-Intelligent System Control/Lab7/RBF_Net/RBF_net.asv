clear all;
clear all;

% network structure 2-5-1
% define: 动量因子alpha;
%         学习速率xite;
%         x取值区间；
alfa = 0.05;
xite = 0.5;
x  = [0,0]';

% 基本思想：bj第j个hidden layer的高斯基函数宽度；越大，高斯基函数越宽，影响网络映射范围；
%          cj第j个hidden layer的中心向量；离输入越近，高斯基函数对输入越敏感；
% define Mb
Mb = 2;
if Mb == 1                   % 高度适中
    b = 1.5*ones(5, 1);
elseif Mb == 2               % 高度较窄
    b = 0.0005*ones(5,1);
end


% define Mc
Mc = 1;
if Mc == 1
    c = [-1.5 -0.5 0 0.5 1.5;
         -1.5 -0.5 0 0.5 1.5];
elseif Mc == 2
    c = 0.1*[-1.5 -0.5 0 0.5 1.5;
             -1.5 -0.5 0 0.5 1.5];
end

w = rands(5,1);
w_1=2;w_2=w_1;
y_1=0;

ts=0.001;
for k=1:1:2000
time(k)=k*ts;
u(k) = 0.5*sin(1*2*pi*k*ts);
y(k) = u(k)^3 + y_1/(1+y_1^2);

x(1) = u(k);
x(2) = y(k);

for j = 1:1:5
    h(j) = exp(-norm(x-c(:,j))^2/(2*b(j)*b(j)));
end

ym(k) = w'*h';
em(k) = y(k) - ym(k);

d_w = xite*em(k)*h';
w = w_1 + d_w + alfa*(w_1-w_2);

y_1=y(k);
w_2=w_1;w_1=w;
end

figure(1);
plot(time, y, 'r', time, ym, 'b:','LineWidth',2);
xlabel('time(s)');ylabel('y and ym');
legend('Ideal value', "Approximation")






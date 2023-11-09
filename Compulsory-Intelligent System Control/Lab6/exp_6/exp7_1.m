xite=0.50;%学习速率
alfa=0.05;%α

%输出层及隐层的连接权值(题目写的结构是2-6-1）
w2=rands(6,1);
w2_1=w2;
w2_2=w2_1;

%输入层及隐层的连接权值
w1=rands(2,6);
w1_1=w1;
w1_2=w1;

%初始化△wij矩阵
dw1=0*w1;
%输入矩阵，x(1)为输入u(k)，x(2)为输出y(k)
x=[0,0]';

u_1=0;%系统输入初始值
y_1=0;%系统输出初始值

I=[0,0,0,0,0,0]';    % 隐层神经元的输入
Iout=[0,0,0,0,0,0]'; % 隐层神经元的输出
FI=[0,0,0,0,0,0]';   % x'/x

ts=0.001; % 采样时间
for  k=1:1:1000
   
time(k)=k*ts;
u(k)=0.50*sin(3*2*pi*k*ts);%系统输入
y(k)=u_1^3+y_1/(1+y_1^2);%系统输出

for  j=1:1:6   
     I(j)=x'*w1(:,j);%隐层神经元的输入xj
     Iout(j)=1/(1+exp(-I(j)));%隐层神经元的输出xj'
end   
yn(k)=w2'*Iout;         % 输出层神经元的输出yn(k)
e(k)=y(k)-yn(k);        %误差计算

%加入动量因子后学习过程权值
w2=w2_1+(xite*e(k))*Iout+alfa*(w2_1-w2_2);

for j=1:1:6
   FI(j)=exp(-I(j))/(1+exp(-I(j)))^2;%?xj'/?xj 反向传播求偏导
end

for i=1:1:2
   for j=1:1:6
      dw1(i,j)=e(k)*xite*FI(j)*w2(j)*x(i);%△wij学习算法
   end
end
%入动量因子后学习过程权值
w1=w1_1+dw1+alfa*(w1_1-w1_2);

%%%%%%%%%%%%%%Jacobian%%%%%%%%%%%%%%%%
yu=0;
for j=1:1:6
   yu=yu+w2(j)*w1(1,j)*FI(j);%对象输出对输入的敏感度y(k)/u(k)（Jacobian信息）
end
dyu(k)=yu;
%为系统两个输入赋值
x(1)=u(k);
x(2)=y(k);
%调整当前与上次权值
w1_2=w1_1;w1_1=w1;
w2_2=w2_1;w2_1=w2;
%改变系统输入输出初始值
u_1=u(k);
y_1=y(k);
end




figure(1);
plot(time,y,'r',time,yn,'b');
xlabel('times');ylabel('y and yn');
figure(2);
plot(time,y-yn,'r');
xlabel('times');ylabel('error');
figure(3);
plot(time,dyu);
xlabel('times');ylabel('dyu');

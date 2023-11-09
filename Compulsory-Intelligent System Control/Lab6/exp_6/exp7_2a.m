xite=0.50;%学习速率
alfa=0.05;%α
%输出层及隐层的连接权值
w2=rands(6,2);
w2_1=w2;w2_2=w2_1;
%输入层及隐层的连接权值
w1=rands(3,6);
w1_1=w1;w1_2=w1;
dw1=0*w1;%初始化△wij矩阵

I=[0,0,0,0,0,0]';%隐层神经元的输入
Iout=[0,0,0,0,0,0]';%隐层神经元的输出
FI=[0,0,0,0,0,0]';% xj'/xj

%三输入两输出
OUT=2; %输出个数
k=0;   %训练次数
E=1.0; %网络训练的最终指标
NS=3;  %样本给出的输入输出行数

while E>=1e-020
k=k+1;  %k为训练次数
times(k)=k;

for s=1:1:NS   %三输入两输出样本  
xs=[1,0,0;
   0,1,0;
   0,0,1];     %理想输入
ys=[1,0;
   0,0.5;
   0,1];       %理想输出

x=xs(s,:);
for j=1:1:6   
    I(j)=x*w1(:,j);%隐层神经元的输入xj
    Iout(j)=1/(1+exp(-I(j)));%隐层神经元的输出xj'
end

yl=w2'*Iout;
yl=yl';        %y1为输出矩阵


el=0;
y=ys(s,:);
for l=1:1:OUT
   el=el+0.5*(y(l)-yl(l))^2;    %输出误差
end
es(s)=el;                       %es(s)为每一次输入的输出误差

E=0;
if s==NS
   for s=1:1:NS
      E=E+es(s);
   end
end
ey=y-yl;%输出误差矩阵
% 加入动量因子后学习过程获得的权值
w2=w2_1+xite*Iout*ey+alfa*(w2_1-w2_2);

for j=1:1:6
   S=1/(1+exp(-I(j)));
   FI(j)=S*(1-S);
end

for i=1:1:3
   for j=1:1:6
       dw1(i,j)=xite*FI(j)*x(i)*(ey(1)*w2(j,1)+ey(2)*w2(j,2));
   end
end
%加入动量因子后学习过程获得的权值
w1=w1_1+dw1+alfa*(w1_1-w1_2);

w1_2=w1_1;w1_1=w1;
w2_2=w2_1;w2_1=w2;
end   %End of for
Ek(k)=E;
end   %End of while
figure(1);
plot(times,Ek,'r');
xlabel('k');ylabel('E');

save wfile w1 w2;%最终权值为用于模式识别的知识库

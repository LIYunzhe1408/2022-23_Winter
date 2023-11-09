xite=0.50;%ѧϰ����
alfa=0.05;%��

%����㼰���������Ȩֵ(��Ŀд�Ľṹ��2-6-1��
w2=rands(6,1);
w2_1=w2;
w2_2=w2_1;

%����㼰���������Ȩֵ
w1=rands(2,6);
w1_1=w1;
w1_2=w1;

%��ʼ����wij����
dw1=0*w1;
%�������x(1)Ϊ����u(k)��x(2)Ϊ���y(k)
x=[0,0]';

u_1=0;%ϵͳ�����ʼֵ
y_1=0;%ϵͳ�����ʼֵ

I=[0,0,0,0,0,0]';    % ������Ԫ������
Iout=[0,0,0,0,0,0]'; % ������Ԫ�����
FI=[0,0,0,0,0,0]';   % x'/x

ts=0.001; % ����ʱ��
for  k=1:1:1000
   
time(k)=k*ts;
u(k)=0.50*sin(3*2*pi*k*ts);%ϵͳ����
y(k)=u_1^3+y_1/(1+y_1^2);%ϵͳ���

for  j=1:1:6   
     I(j)=x'*w1(:,j);%������Ԫ������xj
     Iout(j)=1/(1+exp(-I(j)));%������Ԫ�����xj'
end   
yn(k)=w2'*Iout;         % �������Ԫ�����yn(k)
e(k)=y(k)-yn(k);        %������

%���붯�����Ӻ�ѧϰ����Ȩֵ
w2=w2_1+(xite*e(k))*Iout+alfa*(w2_1-w2_2);

for j=1:1:6
   FI(j)=exp(-I(j))/(1+exp(-I(j)))^2;%?xj'/?xj ���򴫲���ƫ��
end

for i=1:1:2
   for j=1:1:6
      dw1(i,j)=e(k)*xite*FI(j)*w2(j)*x(i);%��wijѧϰ�㷨
   end
end
%�붯�����Ӻ�ѧϰ����Ȩֵ
w1=w1_1+dw1+alfa*(w1_1-w1_2);

%%%%%%%%%%%%%%Jacobian%%%%%%%%%%%%%%%%
yu=0;
for j=1:1:6
   yu=yu+w2(j)*w1(1,j)*FI(j);%�����������������ж�y(k)/u(k)��Jacobian��Ϣ��
end
dyu(k)=yu;
%Ϊϵͳ�������븳ֵ
x(1)=u(k);
x(2)=y(k);
%������ǰ���ϴ�Ȩֵ
w1_2=w1_1;w1_1=w1;
w2_2=w2_1;w2_1=w2;
%�ı�ϵͳ���������ʼֵ
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

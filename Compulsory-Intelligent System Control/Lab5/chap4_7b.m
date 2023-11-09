%Fuzzy PID Control 模糊PID控制
close all;
clear all;

a=readfis('fuzzpid');   %Load fuzzpid.fis 加载模糊推理系统生成的fuzzpid.fis

ts=0.001; %采样时间为1ms
sys=tf(5.235e005,[1,87.35,1.047e004,0]);%对象传递函数
dsys=c2d(sys,ts,'tustin');%采用Z变换对被控对象进行离散化
[num,den]=tfdata(dsys,'v');

u_1=0.0;u_2=0.0;u_3=0.0;%初始值
y_1=0;y_2=0;y_3=0;

x=[0,0,0]';

e_1=0;
ec_1=0;

kp0=0.40;
kd0=1.0;
ki0=0.0;

for k=1:1:3000
    time(k)=k*ts;%运行总时间为3秒
    
    r(k)=sign(sin(2*pi*k*ts)); %输入信号为幅值为1的方波信号
    %Using fuzzy inference to tunning PID  利用模糊推理对PID进行整定
    k_pid=evalfis([e_1,ec_1],a);
    kp(k)=kp0+k_pid(1);
    ki(k)=ki0+k_pid(2);
    kd(k)=kd0+k_pid(3);
    u(k)=kp(k)*x(1)+kd(k)*x(2)+ki(k)*x(3);
    
    if k==300     % Adding disturbance(1.0v at time 0.3s) 在0.3s时增加一个干扰
       u(k)=u(k)+1.0;
    end

    y(k)=-den(2)*y_1-den(3)*y_2-den(4)*y_3+num(1)*u(k)+num(2)*u_1+num(3)*u_2+num(4)*u_3;
    e(k)=r(k)-y(k);
%%%%%%%%%%%%%%Return of PID parameters%%%%%%%%%%%%%%%
   u_3=u_2;
   u_2=u_1;
   u_1=u(k);
   
   y_3=y_2;
   y_2=y_1;
   y_1=y(k);
   
   x(1)=e(k);            % Calculating P
   x(2)=e(k)-e_1;        % Calculating D
   x(3)=x(3)+e(k)*ts;    % Calculating I

   ec_1=x(2);
   e_2=e_1;
   e_1=e(k);
end

figure(1);
plot(time,r,'b',time,y,'r');
xlabel('time(s)');ylabel('rin,yout');%绘制输入r与输出y响应

figure(2);
plot(time,e,'r');
xlabel('time(s)');ylabel('error');%绘制控制误差e响应

figure(3);
plot(time,u,'r');
xlabel('time(s)');ylabel('u');%绘制控制量u响应

figure(4);
plot(time,kp,'r');
xlabel('time(s)');ylabel('kp');%绘制kp自适应整定

figure(5);
plot(time,ki,'r');
xlabel('time(s)');ylabel('ki');%绘制ki自适应整定

figure(6);
plot(time,kd,'r');
xlabel('time(s)');ylabel('kd');%绘制kd自适应整定
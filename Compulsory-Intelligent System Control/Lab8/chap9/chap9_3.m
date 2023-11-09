%Self-Correct control based RBF Identification
clear all;
close all;

xite1=0.15;
xite2=0.50;
alfa=0.05;

% network structure 1-5-1
parameter_weight = 0.5; % 0.1, 1 
% 权值较小时， 输出结果偏离较大，波动明显;
% 随着权值逐渐增大，输出结果偏离逐渐减小，直到重合，波动也逐渐减小，不断向0靠拢
w=parameter_weight*ones(5,1);
v=parameter_weight*ones(5,1);

% 高斯基函数
cij=[-1 -0.5 0 0.5 1]; % 0.5->3, 0.5->9  cj值离输入越近，高斯函数对输入越敏感
bj=10; % 0.5, 10 宽度在合适范围内时，误差在0周围细微波动

h=zeros(5,1);
 
w_1=w;w_2=w_1;
v_1=v;v_2=v_1;
u_1=0;y_1=0;

 ts=0.02;
 for k=1:1:5000
 time(k)=k*ts;
 r(k)=sin(0.1*pi*k*ts);
 
 %Practical Plant;
 g(k)=0.8*sin(y_1);
 f(k)=0.5+0.2*sin(y_1);
 y(k)=g(k)+f(k)*u_1;
 
 for j=1:1:5
    h(j)=exp(-norm(y_1-cij(:,j))^2/(2*bj*bj));
 end
  
 Ng(k)=w'*h;
 Nf(k)=v'*h;

 ym(k)=Ng(k)+Nf(k)*u_1;
 
 e(k)=y(k)-ym(k);
 
 d_w=0*w;
 for j=1:1:5
    d_w(j)=xite1*e(k)*h(j);
 end
 w=w_1+d_w+alfa*(w_1-w_2);
 
 d_v=0*v;
 for j=1:1:5
    d_v(j)=xite2*e(k)*h(j)*u_1;
 end
 v=v_1+d_v+alfa*(v_1-v_2);
 
 u(k)=-Ng(k)/Nf(k)+r(k)/Nf(k);
 
 u_1=u(k);
 y_1=y(k);
 
 w_2=w_1;
 w_1=w;
 
 v_2=v_1;
 v_1=v;
end

figure(1);
plot(time,r,'r',time,y,'b','linewidth',2);
xlabel('Time(second)');ylabel('Position tracking');
figure(2);
plot(time,g,'r',time,Ng,'b','linewidth',2);
xlabel('Time(second)');ylabel('g and Ng');
figure(3);
plot(time,f,'r',time,Nf,'b','linewidth',2);
xlabel('Time(second)');ylabel('f and Nf');
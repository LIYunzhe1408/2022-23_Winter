% 仿真时，先运行模糊推理系统设计程序chap4_7a.m，实现模糊推理系统fuzzpid.fis的设计，
% 并将此模糊推理系统调入内存中，然后运行模糊控制程序chap4_7b.m。
%Fuzzy Tunning PID Control
clear all;
close all;

a=newfis('fuzzpid');%创建一个FIS对象a

a=addvar(a,'input','e',[-3,3]);                        %Parameter e 误差e隶属度函数，在a中添加变量
a=addmf(a,'input',1,'NB','zmf',[-3,-1]);
a=addmf(a,'input',1,'NM','trimf',[-3,-2,0]);
a=addmf(a,'input',1,'NS','trimf',[-3,-1,1]);
a=addmf(a,'input',1,'Z','trimf',[-2,0,2]);
a=addmf(a,'input',1,'PS','trimf',[-1,1,3]);
a=addmf(a,'input',1,'PM','trimf',[0,2,3]);
a=addmf(a,'input',1,'PB','smf',[1,3]);

a=addvar(a,'input','ec',[-3,3]);                       %Parameter ec 误差变化率隶属度函数
a=addmf(a,'input',2,'NB','zmf',[-3,-1]);
a=addmf(a,'input',2,'NM','trimf',[-3,-2,0]);
a=addmf(a,'input',2,'NS','trimf',[-3,-1,1]);
a=addmf(a,'input',2,'Z','trimf',[-2,0,2]);
a=addmf(a,'input',2,'PS','trimf',[-1,1,3]);
a=addmf(a,'input',2,'PM','trimf',[0,2,3]);
a=addmf(a,'input',2,'PB','smf',[1,3]);

a=addvar(a,'output','kp',[-0.3,0.3]);                   %Parameter kp 比例系数kp隶属度函数
a=addmf(a,'output',1,'NB','zmf',[-0.3,-0.1]);
a=addmf(a,'output',1,'NM','trimf',[-0.3,-0.2,0]);
a=addmf(a,'output',1,'NS','trimf',[-0.3,-0.1,0.1]);
a=addmf(a,'output',1,'Z','trimf',[-0.2,0,0.2]);
a=addmf(a,'output',1,'PS','trimf',[-0.1,0.1,0.3]);
a=addmf(a,'output',1,'PM','trimf',[0,0.2,0.3]);
a=addmf(a,'output',1,'PB','smf',[0.1,0.3]);


a=addvar(a,'output','ki',[-0.06,0.06]);             %Parameter ki  积分作用系数ki隶属度函数
a=addmf(a,'output',2,'NB','zmf',[-0.06,-0.02]);
a=addmf(a,'output',2,'NM','trimf',[-0.06,-0.04,0]);
a=addmf(a,'output',2,'NS','trimf',[-0.06,-0.02,0.02]);
a=addmf(a,'output',2,'Z','trimf',[-0.04,0,0.04]);
a=addmf(a,'output',2,'PS','trimf',[-0.02,0.02,0.06]);
a=addmf(a,'output',2,'PM','trimf',[0,0.04,0.06]);
a=addmf(a,'output',2,'PB','smf',[0.02,0.06]);

a=addvar(a,'output','kd',[-3,3]);                   %Parameter kd  微分作用系数kd隶属度函数
a=addmf(a,'output',3,'NB','zmf',[-3,-1]);
a=addmf(a,'output',3,'NM','trimf',[-3,-2,0]);
a=addmf(a,'output',3,'NS','trimf',[-3,-1,1]);
a=addmf(a,'output',3,'Z','trimf',[-2,0,2]);
a=addmf(a,'output',3,'PS','trimf',[-1,1,3]);
a=addmf(a,'output',3,'PM','trimf',[0,2,3]);
a=addmf(a,'output',3,'PB','smf',[1,3]);

rulelist=[1 1 7 1 5 1 1;   %Edit rule base 49条规则
          1 2 7 1 3 1 1;
          1 3 6 2 1 1 1;
          1 4 6 2 1 1 1;
          1 5 5 3 1 1 1;
          1 6 4 4 2 1 1;
          1 7 4 4 5 1 1;
          
          2 1 7 1 5 1 1;
          2 2 7 1 3 1 1;
          2 3 6 2 1 1 1;
          2 4 5 3 2 1 1;
          2 5 5 3 2 1 1;
          2 6 4 4 3 1 1;
          2 7 3 4 4 1 1;
          
          3 1 6 1 4 1 1;
          3 2 6 2 3 1 1;
          3 3 6 3 2 1 1;
          3 4 5 3 2 1 1;
          3 5 4 4 3 1 1;
          3 6 3 5 3 1 1;
          3 7 3 5 4 1 1;
          
          4 1 6 2 4 1 1;
          4 2 6 2 3 1 1;
          4 3 5 3 3 1 1;
          4 4 4 4 3 1 1;
          4 5 3 5 3 1 1;
          4 6 2 6 3 1 1;
          4 7 2 6 4 1 1;
          
          5 1 5 2 4 1 1;
          5 2 5 3 4 1 1;
          5 3 4 4 4 1 1;
          5 4 3 5 4 1 1;
          5 5 3 5 4 1 1;
          5 6 2 6 4 1 1;
          5 7 2 7 4 1 1;
          
          6 1 5 4 7 1 1;
          6 2 4 4 5 1 1;
          6 3 3 5 5 1 1;
          6 4 2 5 5 1 1;
          6 5 2 6 5 1 1;
          6 6 2 7 5 1 1; 
          6 7 1 7 7 1 1;

          7 1 4 4 7 1 1; 
          7 2 4 4 6 1 1;
          7 3 2 5 6 1 1;
          7 4 2 6 6 1 1;
          7 5 2 6 5 1 1;
          7 6 1 7 5 1 1;
          7 7 1 7 7 1 1];
       
a=addrule(a,rulelist); %在a中增加模糊推理规则，a为模糊规则库

a=setfis(a,'DefuzzMethod','centroid'); %Defuzzy 解模糊化采用的是面积重心法（选取
writefis(a,'fuzzpid');                             %隶属度函数曲线与横坐标围成面积的重心作为模糊推理的最终输出值）
% save to fuzzy file "fuzz.fis" which can be 保存到模糊文件tank.fis
a=readfis('fuzzpid');%从磁盘装入FIS

figure(1);
plotmf(a,'input',1);%输入模糊集e（偏差隶属度函数）plotmf--绘制给定变量的隶属度函数
figure(2);
plotmf(a,'input',2);%输入模糊集ec（偏差变化率隶属度函数）
figure(3);
plotmf(a,'output',1);%输出模糊集kp（kp隶属度函数）
figure(4);
plotmf(a,'output',2);%输出模糊集ki（ki隶属度函数）
figure(5);
plotmf(a,'output',3);%输出模糊集kd（kd隶属度函数）
figure(6);
plotfis(a);%绘制模糊推理系统FIS对象a

fuzzy fuzzpid;%规则库和隶属度函数的编辑

showrule(a);% Show fuzzy rule base 显示FIS对象a的规则(把分号去掉则会打印出来)
ruleview fuzzpid;%模糊系统的动态仿真


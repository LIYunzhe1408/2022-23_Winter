clear all;
close all;
z = 0:0.1:60;

u = trimf(z, [0,0,10]);
figure(1);
plot(z, u);

u = trimf(z, [0,10,25]);
figure(1);
plot(z, u);

u = trimf(z, [10,25,40]);
figure(1);
plot(z, u);

u = trimf(z, [25,40,60]);
figure(1);
plot(z, u);

u = trimf(z, [40,40,60]);
figure(1);
plot(z, u);

xlabel('z');
ylabel('Degree of membership')
% Membership function
clear all;
close all;

M = 6;
% Gaussian
if M ==1
    x=0:0.1:10;
    y=gaussmf(x, [1 5]);
end

% General Bell
if M==2
    x=0:0.1:10;
    y=gbellmf(x,[2,4,1]); 
end

% S membership
if M==3
    x=0:0.1:10;
    y=sigmf(x,[2,8]); 
end

% Trapezoid Membership function
if M==4
    x=0:0.1:10;
    y=trapmf(x,[3,5,7,9]); 
end

% Triangle MF
if M==5
    x=0:0.1:10;
    y=trimf(x,[1,5,9]); 
end

% Z MF
if M==6
    x=0:0.1:10;
    y=zmf(x,[4,5]); 
end

plot(x, y, 'k');
    xlabel('x');ylabel('y')
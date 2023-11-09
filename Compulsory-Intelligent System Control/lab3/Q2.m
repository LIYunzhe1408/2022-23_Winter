clear all;
close all;
% Old
for k1 = 1:1:2001
    x1(k1) = (k1-1)*0.1;
    if x1(k1)>=50&x1(k1)<=70
        y1(k1)=( x1(k1) -50)/20;
    elseif x1(k1)>70
        y1(k1) = 1.0;
    else
        y1(k1) = 0;
    end
end
% Young
for k = 1:1:2001
    x(k) = (k-1)*0.1;
    if x(k)>=0&x(k)<=25;
        y(k) = 1.0;
    elseif x(k)>25&x(k)<=70
        y(k)=(70 - x(k))/45;
    else
        y(k) = 0;
    end
end

%  Very Young W
for k2 = 1:1:2001
    x2(k2) = (k2-1)*0.1;
    if and(x(k2)>=0,x(k2)<=25)
        y2(k2) = 1.0;
    elseif x(k2)>25 & x(k2)<=60
        y2(k2)=((70 - x(k2))/45)^2;
    else
        y2(k2) = 0;
    end
end
% not old and not young V
for k3 = 1:1:2001
    x3(k3) = (k3-1)*0.1;
    if x(k3)>=25 & x(k3)<=56.1;
        y3(k3) = 1-(56.1 - x3(k3))/45;
    elseif x(k3)>56.1 & x(k3)<=70
        y3(k3)=1- (x3(k3) -50)/20;
    else
        y3(k3) = 0;
    end
end











figure(1);
plot(x,y,'k');
xlabel('x Years');ylabel('Young Y');
figure(2)
plot(x1,y1,'k');
xlabel('x Years');ylabel('Old O');
figure(3)
plot(x2,y2,'k');
xlabel('x Years');ylabel('Very Young W');
figure(4)
plot(x3,y3,'k');
xlabel('x Years');ylabel('not old and not young V');
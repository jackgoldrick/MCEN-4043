clear all
close all
clc
top=readmatrix('FreeRespTop.txt');
count_to_rad = 2*pi()/16000;
figure()
hold on
top_rad=[top(:,1)-.43 top(:,2).*count_to_rad];
plot(top_rad(:,1),top_rad(:,2), "LineWidth", 2)
axis([0 6 -.1 .1])
title("Top")


y=@(b, t)(b(1).*exp(-b(2).*t).*cos(b(3).*t+b(4)));
omegad=20.17;
sigma=.15;
phi=-0.5;
c=.07;
b=[c sigma omegad phi]
t=[0:0.01:14.5];
plot(t,y(b,t),"--", "LineWidth", 2);
xlabel("time (sec)")
ylabel("theta (radians)")
legend("Data", "Approximation")

% t=[0:0.01:14.5];
% y=@(b, t)(b(1).*exp(-b(2).*t).*cos(b(3).*t+b(4)));
% %plot(t,y);
% beta = [0.078    0.1202   20.1658   -0.4649];
% beta = nlinfit(top_rad(:,1), top_rad(:,2), y, beta)
% plot(t, y(beta, t), 'r')
% 0.0561    0.1202   20.1658   -0.4649

bottom=readmatrix('FreeRespBottom.txt');
figure()
hold on
bottom_rad=[bottom(:,1)-.51, bottom(:,2).*count_to_rad];
plot(bottom_rad(:,1),bottom_rad(:,2),"LineWidth", 2);
axis([0 1 -.1 .1]);



yb=@(bb, t)(bb(1).*exp(-bb(2).*t).*cos(bb(3).*t+bb(4)));
cb=.075;
sigmab=0.88;
omegadb=15.27;
phib=0;
bb=[cb sigmab omegadb phib];
plot(t,yb(bb,t), "--", "LineWidth", 2);
title("Bottom")
xlabel("time (sec)")
ylabel("theta (radians)")
legend("Data", "Approximation")



clear
close
clc

A = 1;
To=1;
t=-2*To:.001:2*To;
a0=3*A/8; %a_0
Wave = a0; %First Part of Fourier Series
wo=2*pi/To;
for ii = 1:20; %or ii = 1:2:100; is also valid since an=0 for ii = even
an_m(ii)= 2*A/(pi^2*ii^2)*(pi*ii*sin(pi/2*ii)+cos(pi*ii/2)-1); %a_n
Wave = Wave + an_m(ii)*cos(ii*wo*t);
end
plot(t,Wave,'LineWidth', 2)
axis([-1 1 -.1 1.1])
title("a_n coefficient test")


%0,13,14,15

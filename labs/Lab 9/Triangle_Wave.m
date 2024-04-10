A = 1;
To=1;
t=-2*To:.001:2*To;
a0=A; %a_0
Wave = a0/2; %First Part of Fourier Series
wo=2*pi/To;
for ii = 1:100; %or ii = 1:2:100; is also valid since an=0 for ii = even
an(ii)= 2*A/(ii*pi)^2*(cos(ii*pi)-1); %a_n
Wave = Wave + an(ii)*cos(ii*wo*t);
end
plot(t,Wave)
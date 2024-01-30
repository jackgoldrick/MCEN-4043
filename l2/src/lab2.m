 time_start = 0;
 time_final = 1;
 t_step = 5000;
 R = 5.1e3;
 C = 3.3e-6;
 k = 1/(R*C);
 
 t = sym('t');


 %% Base

vin_t = linspace(time_start,time_final,t_step);
z = heaviside(vin_t - .000001);
%freq = 1*2*pi;
vin =  z;
Tspan = [time_start time_final];

IC = 0;

options=odeset('RelTol',1e-4);

[vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);

figure(1);
plot(vout_t, vout)
title("Vout v. Time base");


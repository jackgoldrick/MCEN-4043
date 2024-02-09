 time_start = 0;
 time_final = 2;
 t_step = 5000;
   R = 4.99e3;
 C = 3.35e-6;
 k = 1/(R*C);
 

 %% Base

vin_t = linspace(time_start,time_final,t_step);
freq = 1*2*pi;
vin=sin(vin_t*freq);

Tspan = [time_start time_final];

IC = 0;

options=odeset('RelTol',1e-4);

[vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);

figure(1);
plot(vout_t, vout)
title("Vout v. Time base");

%% 1Hz

vin_t = linspace(time_start,time_final,t_step);
freq = 1;
vin=sin(vin_t*freq);

Tspan = [time_start time_final];

IC = 0;

options=odeset('RelTol',1e-4);

[vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);

figure(2);
plot(vout_t, vout)
title("Vout v. Time base 1Hz");


%% 10 Hz

vin_t = linspace(time_start,time_final,t_step);
freq = 10;
vin=sin(vin_t*freq);

Tspan = [time_start time_final];

IC = 0;

options=odeset('RelTol',1e-4);

[vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);

figure(3);
plot(vout_t, vout)
title("Vout v. Time base 10Hz");

%% 50 Hz
vin_t = linspace(time_start,time_final,t_step);
freq = 50;
vin=sin(vin_t*freq);

Tspan = [time_start time_final];

IC = 0;

options=odeset('RelTol',1e-4);

[vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);

figure(4);
plot(vout_t, vout)
title("Vout v. Time base 50Hz");
axis([0 0.1 -1 1])


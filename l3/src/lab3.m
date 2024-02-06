 time_start = 0;
 time_final = 1;
 t_step = 5000;
 R = 5.1e3;
 C = 3.3e-6;
 k = 1/(R*C);
 

 %% Base

vin_t = linspace(time_start,time_final,t_step);
Tspan = [time_start time_final];

sys = tf(k, [1 k]);
[h, h_t ] = impulse(sys, vin_t);

theor_vout = (exp((- vin_t) / (R * C) )) * k;

IC = 0;

options=odeset('RelTol',1e-4);

[vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);
%% experimental data construction
% file = "../res/scope_0.csv";
% opts = detectImportOptions(file);
% 
% data = readmatrix(file, opts);
% 
% t_ex = data(:, 4) - .314;
% 
% vin_ex = data(:, 5);
% 
% vout_ex = data(:, 6);



%% plot 
clf
figure(1)

hold on

title("Voltage v. Time")
xlabel('Seconds')
ylabel('Volts')
xlim([-.1 .8])
ylim([ -.1 1.2])


%%% Simulation
ps = plot(h_t, h,"-.",'LineWidth',3);


%%% Theoretical

pt = plot(vin_t, theor_vout, ":",'LineWidth',3);



%%% Experimental in

% p_ex_in = plot(t_ex, vin_ex, "-",'LineWidth',1);



%%% Experimental out'

% p_ex_out = plot(t_ex, vout_ex, "--", 'LineWidth', 3);


legend('Simulation', 'Theoretical') % 'Experimental In', 'Experimental Out');


hold off



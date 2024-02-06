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

% [vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);
%% experimental 1 data construction
file1 = "../input-data/scope_7.csv";

opts1 = detectImportOptions(file1);

data1 = readmatrix(file1, opts1);

t_ex_1 = data1(:, 1) - .314;

vin_ex_1 = data1(:, 2);

vout_ex_1 = data1(:, 3);

%% experimental 2 data construction

file2 = "../input-data/scope_8.csv";

opts2 = detectImportOptions(file2);

data2 = readmatrix(file2, opts2);

t_ex_2 = data2(:, 1);

vin_ex_2 = data2(:, 2);

vout_ex_2 = data2(:, 3);


%% experimental 3 data construction

file3 = "../input-data/scope_9.csv";

opts3 = detectImportOptions(file3);

data3 = readmatrix(file3, opts3);

t_ex_3 = data3(:, 1);

vin_ex_3 = data3(:, 2);

vout_ex_3 = data3(:, 3);

%% experimental 4 data construction

file4 = "../input-data/scope_10.csv";

opts4 = detectImportOptions(file4);

data4 = readmatrix(file4, opts4);

t_ex_4 = data4(:, 1);

vin_ex_4 = data4(:, 2);

vout_ex_4 = data4(:, 3);

%% experimental 5 data construction

file5 = "../input-data/scope_11.csv";

opts5 = detectImportOptions(file5);

data5 = readmatrix(file5, opts5);

t_ex_5 = data5(:, 1);

vin_ex_5 = data5(:, 2);

vout_ex_5 = data5(:, 3);

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

hold off

figure(2);
hold on

title("Experimental Voltage v. Time")
xlabel('Seconds')
ylabel('Volts')
xlim([-.1 .05])
ylim([ -.1 1.1])

%% Experimental in

    % One
        p_ex_in_1 = plot(t_ex_1, vin_ex_1, "-",'LineWidth',1);

    % Two
        p_ex_in_2 = plot(t_ex_2, vin_ex_2, "-",'LineWidth',1);

    % Three 
        p_ex_in_3 = plot(t_ex_3, vin_ex_3, "-",'LineWidth',1);

    % Four
        p_ex_in_4 = plot(t_ex_4, vin_ex_4, "-",'LineWidth',1);

    % Five 
        p_ex_in_5 = plot(t_ex_5, vin_ex_5, "-",'LineWidth',1);


%% Experimental out

    % One
        p_ex_out_1 = plot(t_ex_1, vout_ex_1, "--", 'LineWidth', 3);

    % Two 
        p_ex_out_2 = plot(t_ex_2, vout_ex_2, "--", 'LineWidth', 3);
    
    % Three
        p_ex_out_3 = plot(t_ex_3, vout_ex_3, "--", 'LineWidth', 3);

    % Four 
        p_ex_out_4 = plot(t_ex_4, vout_ex_4, "--", 'LineWidth', 3);

    % Five
        p_ex_out_5 = plot(t_ex_5, vout_ex_5, "--", 'LineWidth', 3);


% legend('Simulation', 'Theoretical') % 'Experimental In', 'Experimental Out');


hold off



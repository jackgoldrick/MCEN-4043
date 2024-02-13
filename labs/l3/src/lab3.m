 time_start = 0;
 time_final = 1;
 t_step = 5000;
 R = 5.1e3;
 C = 3.3e-6;
 kt = 1/(R*C);

 tau_k = R * C;
 

 %% Base

vin_t = linspace(time_start,time_final,t_step);
Tspan = [time_start time_final];

sys = tf(kt, [1 kt]);
[h, h_t ] = impulse(sys, vin_t);

theor_vout = (exp((- vin_t) / (R * C) )) * kt;

IC = 0;

options=odeset('RelTol',1e-4);

% [vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);

%% experimental 1 data construction
file1 = "../input-data/scope_7.csv";

opts1 = detectImportOptions(file1);

data1 = readmatrix(file1, opts1);

t_ex_1 = data1(3:10002, 1) + .1 - .0061;

vin_ex_1 = data1(3:10002, 2) + .33165829;

vout_ex_1 = data1(3:10002, 3) + .33165829;

%% experimental 2 data construction

file2 = "../input-data/scope_8.csv";

opts2 = detectImportOptions(file2);

data2 = readmatrix(file2, opts2);

t_ex_2 = data2(3:10002, 1) + .1 - .11152;

vin_ex_2 = data2(3:10002, 2) + .648241;

vout_ex_2 = data2(3:10002, 3) + .648241;


%% experimental 3 data construction

file3 = "../input-data/scope_9.csv";

opts3 = detectImportOptions(file3);

data3 = readmatrix(file3, opts3);

t_ex_3 = data3(3:10002, 1) + .1 - .07682;

vin_ex_3 = data3(3:10002, 2) + 1.28643215;

vout_ex_3 = data3(3:10002, 3) + 1.28643215 - .00502513;

%% experimental 4 data construction

file4 = "../input-data/scope_10.csv";

opts4 = detectImportOptions(file4);

data4 = readmatrix(file4, opts4);

t_ex_4 = data4(3:10002, 1) + .1 -.10364;

vin_ex_4 = data4(3:10002, 2) + 2.50251 + .0351784;

vout_ex_4 = data4(3:10002, 3) + 2.50251;

%% experimental 5 data construction

file5 = "../input-data/scope_11.csv";

opts5 = detectImportOptions(file5);

data5 = readmatrix(file5, opts5);

t_ex_5 = data5(3:10002, 1) + .1 - .12972;

vin_ex_5 = data5(3:10002, 2) + 4.82915 + .19598;

vout_ex_5 = data5(3:10002, 3) + 4.82915  - 0.00000432 - 3.90677853295048e-16;

%% plot 
clf
f1 = figure(1);

hold on

title("Voltage v. Time")
xlabel('Seconds')
ylabel('Volts')
xlim([0 .8])
ylim([ -.1 1.2])


%%% Simulation
ps = plot(h_t, h,"-.",'LineWidth',3);


%%% Theoretical

pt = plot(vin_t, theor_vout, ":",'LineWidth',3);

legend('Simulation', 'Theoretical');
hold off

f2 = figure(2);
hold on

title("Experimental Input v. Time")
xlabel('Seconds')
ylabel('Volts')
xlim([0 .025])
ylim([ -.1 10])

%% Experimental in

    % One
        p_ex_in_1 = plot(t_ex_1, vin_ex_1, "-",'LineWidth',1);

    % Two
        p_ex_in_2 = plot(t_ex_2, vin_ex_2, "-",'LineWidth',1);
    % 
    % Three 
        p_ex_in_3 = plot(t_ex_3, vin_ex_3, "-",'LineWidth',1);
    % 
    % Four
        p_ex_in_4 = plot(t_ex_4, vin_ex_4, "-",'LineWidth',1);
    % 
    % Five 
        p_ex_in_5 = plot(t_ex_5, vin_ex_5, "-",'LineWidth',1);
    legend('Experiment .016', 'Experiment .008','Experiment .004', 'Experiment .002', 'Experiment .001');
    hold off

%% Experimental out
    f3 = figure(3);
    hold on

    title("Experimental Output v. Time")
    xlabel('Seconds')
    ylabel('Volts')
    xlim([0 .2])
    ylim([ 0 1])

    % One
        p_ex_out_1 = plot(t_ex_1, vout_ex_1, "--", 'LineWidth', 2);
    % 
    % Two 
        p_ex_out_2 = plot(t_ex_2, vout_ex_2, "--", 'LineWidth', 2);
    % 
    % Three
        p_ex_out_3 = plot(t_ex_3, vout_ex_3, "--", 'LineWidth', 2);
    % 
    % Four 
        p_ex_out_4 = plot(t_ex_4, vout_ex_4, "--", 'LineWidth', 2);
    % 
    % Five
        p_ex_out_5 = plot(t_ex_5, vout_ex_5, "--", 'LineWidth', 2);
        legend('Experiment .016', 'Experiment .008','Experiment .004', 'Experiment .002', 'Experiment .001');
    hold off
    
    f4 = figure(4);
     hold on 
     title("Experimental & Theoretical Output  v. Time")
        xlabel('Seconds')
        ylabel('Volts')
        xlim([0 .2])
        ylim([ 0 1])
        p10 = plot(t_ex_5, vout_ex_5, "--", 'LineWidth', 2);
        p11 = plot(vin_t - (.08), theor_vout, ":",'LineWidth',3);
        legend(".001 Experimental", "Theoretical");


    
       hold off


format longg
% N is degree of poly
N = 25;
b = zeros(10000,5);
c = zeros(10000,1) + 1;
A = [zeros(10000, N + 1, 5)];
x = zeros(N + 1,1, 5);
  

for j=0:N
    A(:, j + 1, 1) =  t_ex_1 .^ j;
    A(:, j + 1, 2) =  t_ex_2 .^ j;
    A(:, j + 1, 3) =  t_ex_3 .^ j;
    A(:, j + 1, 4) =  t_ex_4 .^ j;
    A(:, j + 1, 5) =  t_ex_5 .^ j;

end 

% b(:, 1) = vout_ex_1;
% b(:, 2) = vout_ex_2;
% b(:, 3) = vout_ex_3;
% b(:, 4) = vout_ex_4;
% b(:, 5) = vout_ex_5;
b(:, 1) = smoothdata(vout_ex_1, 1000);
b(:, 2) = smoothdata(vout_ex_2, 1000);
b(:, 3) = smoothdata(vout_ex_3, 1000);
b(:, 4) = smoothdata(vout_ex_4, 1000);
b(:, 5) = smoothdata(vout_ex_5, 1000);
% b(:, 1) = smoothdata(rescale(vout_ex_1, 0, 1), "SamplePoints",rescale(t_ex_1, 0, 1));
% b(:, 2) = smoothdata(rescale(vout_ex_2, 0, 1), "SamplePoints",rescale(t_ex_2, 0, 1));
% b(:, 3) = smoothdata(rescale(vout_ex_3, 0, 1), "SamplePoints",rescale(t_ex_3, 0, 1));
% b(:, 4) = smoothdata(rescale(vout_ex_4, 0, 1), "SamplePoints",rescale(t_ex_4, 0, 1));
% b(:, 5) = smoothdata(rescale(vout_ex_5, 0, 1), "SamplePoints",rescale(t_ex_5, 0, 1));

coef = zeros(N+1, 1, 5);
tau = zeros(N+1, 1, 5);

RC_AVG = zeros(5,1);


for i = 1:5
    A_P = A(:, :, i)';
    A_R = A(:, :, i);
    y = (A_P * A_R);

    y_norm = 1;
    
    y_INV = 0;


    y_mult = ((y) \ (A_P));


    x(:, :, i) = ((y_mult) * b(:,i));

   
    
    coef(:,1,i) = x(:, 1, i);

    for k=1:(N+1)
        kl = 1;
        k2 = -1;
        if ( k > 1)
            kl = k - 1;
            k2 = kl;

        end 

        tau(k, 1, i) = (factorial(kl) * abs(coef(k,1, i)) )^(1/(- k2));
        

    end
    fit = tau(1:(N+1), 1, i);
    RC_AVG(i) = (sum(fit, "all") / (N + 1));
    



   





end 
% Average Time Constant: 0.016844 Seconds
AVG_RC_AVG = sum(RC_AVG, "all") / (5);
fprintf("Average Time Constant: ");
fprintf("%f", AVG_RC_AVG);
fprintf(" Seconds");
fprintf("\n");
p = 2;


%uiwait(f1);
%uiwait(f2);
%uiwait(f3);




%set up nice workspace
clear all
close all
clc

%% Noise input (1) and Response (2) data construction
file1 = "../input-data/scope_18.csv";

opts1 = detectImportOptions(file1);

data1 = readmatrix(file1, opts1);
% @param_1 tells matlab the range to sample from the excel, where the
% numbers are the rows
% @param_2 tells matlab what excel column to pick from
%  you likely will need to adjust the data differently on either excel or
%  matlab which could cause the sample range, cols, and biases to change.
% I did most of the leg work in excel by finding the minimum of each column
% and normalizing based off that .
t_N = data1(3:2200, 1);

noise_in = data1(3:10000, 2);

noise_out = (data1(3:10000, 3));

%% Step input (1) and Response (2) data construction 503:1248

file2 = "../input-data/scope_21.csv";

opts2 = detectImportOptions(file2);

data2 = readmatrix(file2,opts2);
%508 is max
t_imp = linspace(0,0.9,(5000-1315)+1);
%data2(1302:5000, 1);

% the .0101 may change based on the graph of the impulse response
imp_out = ((data2(1315:5000, 3)).* 100 +492); % 10.1 /2);
% len = length(step_out);
% diff = length(1500:1752);
% for i=0: diff
%     step_out(len - i) = 0;
% end

DeltaT = .0001; % if using 10ks/sec = 10000 samples/sec sampling rate
ConvData = conv(imp_out, noise_in) .* DeltaT;
Time = DeltaT .*(0:(length(noise_in)-1));

%First requested figure: impulse response graph, chopped at beginning of
%decay
figure(1)
pl_imp_response = plot(t_imp, imp_out);
title("Impulse Response")
xlabel("time (s)")
ylabel("Vout (V)")

%Second requested figure: real noise + response graph
figure(2)
hold on
pl_noise_in = plot(Time, noise_in);
pl_noise_out = plot(Time, noise_out);
title("Noise in and out")
xlabel("time (s)")
ylabel("Vout (V)")
legend('Noise in', 'Noise out')
hold off

%Third requested figure: graph of real noise out vs convolved noise out
figure(3)

hold on
pl_conv = plot(Time, ConvData(1:(length(noise_in)) ), 'r' );
pl_expect = plot(Time, noise_out, 'b');
title("Real Noise Response vs. Convolved Noise Response")
xlabel("time (s)")
ylabel("Vout (V)")
legend('Convolved Output', 'Experimental Output')
hold off

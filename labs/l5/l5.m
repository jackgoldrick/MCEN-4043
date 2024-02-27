%set up nice workspace
clear all
close all
clc

%% Part 1: Input Voltage = 1 V
file1 = "scope_6.csv";

opts1 = detectImportOptions(file1);

data1 = readmatrix(file1, opts1);

t_N = 1000.*data1(2794:3794, 1)-107.58;

V_in = data1(2794:3794, 2)+1;

V_out = (data1(2794:3794, 3));
figure(1);
hold on
plot(t_N, V_in, '--', 'LineWidth', 2);
plot(t_N, V_out, 'LineWidth', 2);
title("Experiment 1: Input = 1V")
xlabel("time (ms)")
ylabel("V out (V)")
legend('V in', 'V out')
axis([0 60 0 1.3])
%% Part 2: Input Voltage = 2V

file2 = "scope_8.csv";

opts2 = detectImportOptions(file2);

data2 = readmatrix(file2,opts2);
t_N2 = 1000.*data2(1418:2418, 1)-24.9;

V_in2 = data2(1418:2418, 2)+2;

V_out2 = (data2(1418:2418, 3));
figure(2);
hold on
plot(t_N2, V_in2, '--', 'LineWidth', 2);
plot(t_N2, V_out2, 'LineWidth', 2);
title("Experiment 2: Input = 2V")
xlabel("time (ms)")
ylabel("V out (V)")
legend('V in', 'V out')
axis([0 60 0 2.3])

%% Part 3: Input Voltage = Whatever we want in order to minimize rise time

file3 = "scope_19.csv";

opts3 = detectImportOptions(file3);

data3 = readmatrix(file3,opts3);
t_N3 = 1000.*data2(1003:2000, 1)-.72;

V_in3 = data3(1003:2000, 2);

V_out3 = (data3(1003:2000, 3));
figure(3);
hold on

plot(t_N3, V_out3, 'LineWidth', 2);
title("Experiment 3: Variable Input, Compared to Steps")
xlabel("time (ms)")
ylabel("V out (V)")
plot(t_N, V_out, 'LineWidth', 2)
plot(t_N2, V_out2, 'LineWidth', 2)
theoretical=[0, 1, 1];
t_theo=[0, 0.001, 60];
plot(t_theo,theoretical, 'LineWidth', 2)
axis([0 60 0 1.2])
legend("V in=Arb","V in=1V", "V in=2V", "Ideal")

%Part 3 subpart: what was our input arbitrary waveform?
figure(4)
plot(t_N3, V_in3)
title("Experiment 3's Input Voltage")
xlabel("time (ms)")
ylabel("V in (V)")
axis([-1 60 0 5.5])
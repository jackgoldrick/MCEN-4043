%set up nice workspace
clear all
close all
clc

%frequency adjuster: 6
file1 = "scope_13.csv";

opts1 = detectImportOptions(file1);

data1 = readmatrix(file1, opts1);

t_N = data1(:, 1);

V_in = data1(:, 2);

figure(1);
hold on
plot(t_N, V_in, 'LineWidth', 2);
xlabel("Time (sec)")
ylabel("Voltage (V)")
title("M&M Wave for TCCR2B = (6 << CS20)")
axis([0.01 .23 -.1 5.3])

%for 1 instead of 6
file1 = "scope_17.csv";

opts1 = detectImportOptions(file1);

data1 = readmatrix(file1, opts1);

t_N = data1(:, 1);

V_in = data1(:, 2);

figure(2);
hold on
plot(t_N, V_in, 'LineWidth', 2);
xlabel("Time (sec)")
ylabel("Voltage (V)")
title("M&M Wave for TCCR2B = (1 << CS20)")

axis([0 .01 -.1 5])

%for 3 instead of 6
file1 = "scope_18.csv";

opts1 = detectImportOptions(file1);

data1 = readmatrix(file1, opts1);

t_N = data1(:, 1);

V_in = data1(:, 2);

figure(23);
hold on
plot(t_N, V_in, 'LineWidth', 2);
xlabel("Time (sec)")
ylabel("Voltage (V)")
title("M&M Wave for TCCR2B = (3 << CS20)")

axis([0 .1 -.1 5])
% time vector with step of .001
DT = .001;
t1 = 0:DT:4;
t2 = 4 + DT:DT:10;
t = [t1 t2];

tau = .1;


y1 = 3 * (1 - exp(-t1 / tau));

y2 = 3 * (1 - exp(-t2 / tau)) - 3 * (1 - exp(-(t2 - 4) / tau));

y = [y1 y2];

plot(t, y, 'LineWidth', 2);
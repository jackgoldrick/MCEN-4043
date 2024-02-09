out = sim("problem4");


t = out.tout;


a = .5;

w = sqrt(3) / 2;
ws = .75;
q = 1/ w;


c0 = t;
ch1 = (t - 1) .* heaviside(t - 1);
ch2 = (t - 2) .* heaviside(t - 2);

s0 = - q * (exp((-a) * t) .* sin( w * t));
sh1 =  - q * (exp((-a) * (t-1)) .* sin( w * (t-1))) .* heaviside(t - 1);
sh2 = - q * (exp(-a * (t-2)) .* sin( w * (t-2))) .* heaviside(t - 2);


y = ( c0 - 2 * (ch1) + ch2 + s0 - 2 * sh1 + sh2 );





f1 = figure(1);
hold on
ps0 = plot(out.tout, y, "-.",'LineWidth',2);
% ps1 = plot(out.tout, y1, "-.",'LineWidth',3);
% ps2 = plot(out.tout, y2, "-.",'LineWidth',3);


ps_sim = plot(out.simout,"--",'LineWidth',3);

legend('Theoretical', 'Simulation Out', 'Simulation In');

hold off

uiwait(f1);



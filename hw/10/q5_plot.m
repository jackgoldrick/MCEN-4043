function q5_plot(A, N, T0)
    
t = 0:.0001:2;
a = @(n) ((2 * A)/(pi * n )^2) * ((-1)^n - 1);
a_n = zeros(N, 1);
a_n(1) = A;
cos_an = zeros(length(t), N);
cos_f = @(n,t) (cos(((2*pi*n) / T0)  .* t));
cos_an(:, 1) = .5 * ones (length(t), 1);

for i=2:N
    cos_an(:,i) = cos_f(i-1, t);
    a_n(i) = a(i-1);
end 

x_t = cos_an * a_n;
figure(1)
plot(t, x_t, '-');



 

end
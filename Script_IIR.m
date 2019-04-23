clc;

clear;

close all;

fs = 1e3;

Ts = 1/fs;

N = 100;

b = 0.2;

a = 1 - b;

x_n = [ zeros(1,20) 1 zeros(1,15) 1 zeros(1,N-20-15-1) ];

y_n = zeros(1,N);

y_n(1) = a*x_n(1);

for k = 2:N
    
    y_n(k) = a*x_n(k) + b*y_n(k-1);
    
end

y_n = y_n + 0.1*randn(size(y_n));

x_r = zeros(1,N);

x_r(1) = (1/a)*y_n(1);

for k = 2:N

    x_r(k) = (1/a)*y_n(k) - (b/a)*y_n(k-1);
    
end

figure()
subplot(3,1,1);
plot(x_n); %Grafica x(t) cuantificado
axis('tight');
subplot(3,1,2);
plot(y_n); %Grafica h(t) cuantficado
axis('tight');
subplot(3,1,3);
plot(x_r); %Grafica h(t) cuantficado
axis('tight');

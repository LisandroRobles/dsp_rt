%Script_NoisySignal - Verifica que un filtro MA reduce la SNR de una señal
%Genera una señal senoidal de frecuencia, amplitud y SNR variable y la
%promedia con un filtro de media móvil, verificando la reducción del SNR
%
% Syntax:  Script_NoisySignal
%
% Other m-files required: Func_Wgn
% Subfunctions: none
% MAT-files required: none

% Author: Lisandro Robles
% email: LisandroRobles1@gmail.com
% Last revision: 11/04/2019

%------------- BEGIN CODE -------------------------------------------------
%% Preparación del entorno

clc; %Borra la consola

clear; %Borra el workspace

close all; %Cierra todas las figuras abiertas

%% Parámetros de las señales

N = 32; %Largo de las señales

numbits = 16; %16 bits para la parte fraccional y 1 para la parte entera
              %1 bit de signo (Total 18 bits)  

F = (2^numbits); %Factor de escala para pasar de float a modulo de 16 bits

%F_div = int64(2^(numbits + log2(N))); %El log2 esta de más, pero se debe
%considerar (tiene que ver con la saturacion del acumulador)
F_div = int32(2^numbits);

%% Parámetros del muestreo

fs = 1e3; %Frecuencia de muestreo

Ts = 1/fs; %Período de muestreo

t = 0:Ts:(N-1)*Ts; %Vector temporal

%% Señal

tau_x = 0.01; % Constante de tiempo de la señal

x1 = exp(-t/tau_x);

x2 = -exp(-t/tau_x); % Genera x(t)

x1_norm = x1/max(abs(x1)); % Normaliza la señal en el rango [-1:+1]
                           % Así solo necesito 1 bit para la parte entera
x2_norm = x2/max(abs(x2)); 

%Cuantiza la señal entre [-2^16:+2^16]
%La parte fraccional almacenada en el bit 0 a 15
%El bit 16 es para la parte entera
%El bit 17 es para el signo
%Lo almacena como int de 32 bits ya que para almacenar el resultado de la
%multiplicación entre 2 numeros de 16 bits necesito para no tener overflow
%en el pero de los casos 32 bits:
% sum_2^nbits_([nbits]) = [nbits] + log2(2^nbits) = [2*nbits] = [32]
%Esto es para no tener overflow en la multiplicación de la convolución
% Pero solo me interesan las primeros 17 bits menos significantes (1.16)

%Luego, extiendo el tipo de buffer a 64 bits ya que para el acumulador de
%convolución necesito 5 bits de guarda para evitar overflow (37 bits)

x1_fp = int64(round(x1_norm*F));
x2_fp = int64(round(x2_norm*F));
                                
x1_bin = dec2bin(typecast(x1_fp,'uint64'),64); %Vector binario (CA2)
x2_bin = dec2bin(typecast(x2_fp,'uint64'),64); %Vector binario (CA2)

%% Kernel

tau_h = 0.02; %Constante de tiempo del kernel

h = exp(-t/tau_h); %Genera el kernel

h_norm = h/max(abs(h)); %Normaliza el kernel

h_fp = int64(round(h_norm*F)); %Cuantización del kernel

h_bin = dec2bin(typecast(h_fp,'uint32'),64); %Vector binario

%% Producto punto

% acum = int64(0); %Acumulador 32 bits (se agrando a 64 ya que necesito 37)
% 
% for i = 1:N
%     acum = acum + int64(int32(h_fp(i))*int32(x_fp(i))); %Para h(i)*x(i) necesito 2*nbits
%     acum_bin = dec2bin(typecast(acum,'uint64'),64); %Vector binario (CA2)
% end

y_fp = Func_MyConv(x1_fp,h_fp);

y_f = fix(double(y_fp)/double(F_div));
%Me quedo con los bits de la parte alta
%Descarto 16 bits de abajo
%Fix solo toma la parte entera
%Fix solo corta, el error deberia llevarlo hacia abajo

y_f_double = double(y_f)/F; %Lo llevo a la escala de -1 a 1

y = conv(x1_norm,h_norm);

%% CÃ¡lculo el error

e = y_f_double - y;

u = mean(e);

v = var(e);

%% Grafica las señales

figure()
subplot(2,1,1);
plot(y_f_double); %Grafica x(t) cuantificado
axis('tight');
subplot(2,1,2);
plot(y); %Grafica h(t) cuantficado
axis('tight');

figure();
plot(e);
axis('tight');

figure()
histogram(e)

%Los filtros IIR realimentan el error (traen problemas por aritmetica porque lo realimenta)
%------------- END OF CODE ------------------------------------------------
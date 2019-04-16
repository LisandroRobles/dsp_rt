%Script_NoisySignal - Verifica que un filtro MA reduce la SNR de una se�al
%Genera una se�al senoidal de frecuencia, amplitud y SNR variable y la
%promedia con un filtro de media m�vil, verificando la reducci�n del SNR
%
% Syntax:  Script_NoisySignal
%
% Other m-files required: Func_Wgn
% Subfunctions: none
% MAT-files required: none

% Author: Lisandro Robles
% email: LisandroRobles1@gmail.com
% Last revision: 27/03/2019

%------------- BEGIN CODE -------------------------------------------------
%% Preparaci�n del entorno

clc;        %Borra la consola

clear;      %Borra el workspace

close all;  %Cierra todas las figuras abiertas

%% Par�metros del muestreo

Fs = 1000;  %Frecuencia de muestreo

N = 1000;   %Cantidad de muestras

Ts = 1/Fs;  %Período de muestreo

%% Par�metros de la se�al

fsig = 10; %Frecuencia de la se�al

Amp = 2; %Amplitud de la se�al

SNR = 10; %Relaci�n se�al a ruido

%% Par�metros del filtro de media m�vil

lkernel = 10; %Largo del moving average

kernel = (1/lkernel)*ones(1,lkernel); %Respuesta al impulso

%% Generaci�n de la se�al con ruido s(t) = x(t) + n(t)

t = 0:Ts:((N-1)*Ts); %Vector temporal

x_t = Amp*sin(2*pi*fsig*t); %Genera la se�al sin ruido

n_t = Func_Wgn(x_t,SNR); %Crea ruido blanco gaussiano para la SNR deseada

s_t = x_t + n_t; %Suma el ruido a la señal

%% Verifica SNR

SNR_in = 10*log10(var(x_t)/var(n_t)); %SNR real obtenida

fprintf('SNR deseado: %f dB\n',SNR); %Imprime el SNR deseado

fprintf('SNR in: %f dB\n',SNR_in); %Imprime el SNR obtenido

%% Aplica el filtro de media m�vil a s(t)

ys_t = filter(kernel,1,s_t); %Moving average de la se�al

%% Grafica las se�ales

figure()

h1 = subplot(4,1,1);
plot(t,x_t); %Grafica la se�al sin ruido
h2 = subplot(4,1,2);
plot(t,n_t); %Grafica el ruido
h3 = subplot(4,1,3);
plot(t,s_t); %Grafica la se�al con ruido
h4 = subplot(4,1,4);
plot(t,ys_t); %Gr�fica la se�al filtrada
linkaxes([h1,h2,h3,h4],'xy');

%% Mide la SNR a la salida del filtro

yx_t = filter(kernel,1,x_t); %Filtro de media m�vil a x(t)

yn_t = filter(kernel,1,n_t); %Filtro de media m�vil a n(t)

SNR_out = 10*log10(var(yx_t)/var(yn_t)); %C�lcula la SNR de salida

fprintf('SNR out: %f dB\n',SNR_out); %Imprime la SNR de salida

%------------- END OF CODE ------------------------------------------------


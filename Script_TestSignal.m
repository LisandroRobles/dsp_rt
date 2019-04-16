%Script_TestSignal - Grafica una señal senoidal y su espectro de módulo
%Genera una señal senoidal de frecuencia y amplitud variable a partir de
%los parámetros del muestreo y la grafica. Posteriormente, cálcula su
%espectro de módulo y lo gráfica.
%
% Syntax:  Script_TestSignal
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lisandro Robles
% email: LisandroRobles1@gmail.com
% Last revision: 27/03/2019

%------------- BEGIN CODE -------------------------------------------------
%% Preparación del entorno

clc;   %Borra la consola

clear; %Cierra el workspace

close all; %Cierra todas las ventanas

%% Parámetros del muestro

Fs = 1000; %Frecuencia de muestreo

N = 1000; %Cantidad de puntos

Ts = 1/Fs; %Período de muestreo

%% Parámetros de la señal

fsig = 75.5; %Frecuencia de la señal

Amp = 2; %Amplitud de la señal

%% Generación de las señales

t = 0:Ts:((N-1)*Ts); %Eje de tiempo

x_t = Amp*sin(2*pi*fsig*t); %Genera la señal

%% Grafica la señal en tiempo

figure();
plot(t,x_t); %Grafica x(t)

%% Cálcula el espectro de módulo de la señal         
         
Esp = abs(fft(x_t)); %Espectro de la señal

Resp = Fs/N; %Resolución espectral

f = 0:Resp:((N-1)*Resp); %Vector frecuencial

%% Grafica el espectro de módulo de la señal

figure()
plot(f,Esp); %Grafica |X(f)|
 
%------------- END OF CODE ------------------------------------------------
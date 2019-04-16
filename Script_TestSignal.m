%Script_TestSignal - Grafica una se�al senoidal y su espectro de m�dulo
%Genera una se�al senoidal de frecuencia y amplitud variable a partir de
%los par�metros del muestreo y la grafica. Posteriormente, c�lcula su
%espectro de m�dulo y lo gr�fica.
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
%% Preparaci�n del entorno

clc;   %Borra la consola

clear; %Cierra el workspace

close all; %Cierra todas las ventanas

%% Par�metros del muestro

Fs = 1000; %Frecuencia de muestreo

N = 1000; %Cantidad de puntos

Ts = 1/Fs; %Per�odo de muestreo

%% Par�metros de la se�al

fsig = 75.5; %Frecuencia de la se�al

Amp = 2; %Amplitud de la se�al

%% Generaci�n de las se�ales

t = 0:Ts:((N-1)*Ts); %Eje de tiempo

x_t = Amp*sin(2*pi*fsig*t); %Genera la se�al

%% Grafica la se�al en tiempo

figure();
plot(t,x_t); %Grafica x(t)

%% C�lcula el espectro de m�dulo de la se�al         
         
Esp = abs(fft(x_t)); %Espectro de la se�al

Resp = Fs/N; %Resoluci�n espectral

f = 0:Resp:((N-1)*Resp); %Vector frecuencial

%% Grafica el espectro de m�dulo de la se�al

figure()
plot(f,Esp); %Grafica |X(f)|
 
%------------- END OF CODE ------------------------------------------------
%Script_TestIIR - Verifica el correcto funcionamiento de Func_MyIIR_Simple
%Genera un ruido n(t) de longitud N y varianza especifica y le aplica la
%función Func_MyIIR_Simple() comparando el resultado con filter()
%
% Syntax:  Script_TestIIR
%
% Other m-files required: Func_MyIIR_Simple
% Subfunctions: none
% MAT-files required: none

% Author: Lisandro Robles
% email: LisandroRobles1@gmail.com
% Last revision: 27/03/2019

%------------- BEGIN CODE -------------------------------------------------
%% Preparación del entorno

clc;        %Borra la consola

clear;      %Borra el workspace

close all;  %Cierra todas las figuras abiertas

%% Parámetros de n(t)

N = 1000; %Cantidad de muestras

var = 2; %Varianza deseada

%% Parámetros del filtro - y[n] = a*x[n] + b*y[n-1]

a = 1; 
b = 1;

num = [a 0]; %Numerador de la transferencia
den = [1 -b]; %Denominador de la transferencia

%% Generación de n(t)

n_t = sqrt(var).*randn(1,N); %Genera un ruido blanco gaussiano d

%% Aplicación del filtro

y1_t = Func_MyIIR_Simple(n_t,a,b); %Usando la función propia

y2_t = filter(num,den,n_t); %Usando filter()

%% Grafica los resultados

figure()
h1 = subplot(3,1,1);
plot(n_t); %Grafica n(t)
h2 = subplot(3,1,2);
plot(y1_t); %Gráfica la salida de Func_MyIIR_Simple()
h3 = subplot(3,1,3);
plot(y2_t); %Gráfica la salida de filter()
linkaxes([h1,h2,h3],'x');

%------------- END OF CODE ------------------------------------------------
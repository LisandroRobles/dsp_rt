%Script_TestPI - Verifica que PI esta almacenado con presición finita
%Genera un vector de números múltiplo de PI y se obtiene el valor de una 
%senoidal para esos valores. Luego, se gráfica el resultado y se observa
%que hay un artefacto en lugar de cero. Esto se explica en el límite de la
%precisión de PI, que esta almacenado como fracción.
%
% Syntax:  Script_TestPI
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

%% Generación de las señales

eje_x = (0:99)*pi; %Vector con multiplos de pi (sin = 0)

y = sin(eje_x); %Cálcula el seno en puntos múltiplos de pi

%% Grafica la señal en tiempo

figure();
plot(eje_x,y); %Grafica el resultado

%------------- END OF CODE ------------------------------------------------
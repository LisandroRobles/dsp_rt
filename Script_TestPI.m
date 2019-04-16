%Script_TestPI - Verifica que PI esta almacenado con presici�n finita
%Genera un vector de n�meros m�ltiplo de PI y se obtiene el valor de una 
%senoidal para esos valores. Luego, se gr�fica el resultado y se observa
%que hay un artefacto en lugar de cero. Esto se explica en el l�mite de la
%precisi�n de PI, que esta almacenado como fracci�n.
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
%% Preparaci�n del entorno

clc;   %Borra la consola

clear; %Cierra el workspace

close all; %Cierra todas las ventanas

%% Generaci�n de las se�ales

eje_x = (0:99)*pi; %Vector con multiplos de pi (sin = 0)

y = sin(eje_x); %C�lcula el seno en puntos m�ltiplos de pi

%% Grafica la se�al en tiempo

figure();
plot(eje_x,y); %Grafica el resultado

%------------- END OF CODE ------------------------------------------------
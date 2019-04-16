%Script_TestSuma - Verifica que con aritmética discreta la suma no es
%conmutativa. 
%Genera una secuencia de números aleatorios de longitud variable N para
%posteriormente alterar el orden de los elementos. Luego, cálcula la suma
%de cada secuencia y verifica que no dan lo mismo.
%
% Syntax:  Script_TestSuma
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lisandro Robles
% email: LisandroRobles1@gmail.com
% Last revision: 27/03/2019

%------------- BEGIN CODE -------------------------------------------------
%% Preparación del entorno

clc; %Borra la consola

clear; %Cierra el workspace

close all; %Cierra todas las ventanas

%% Parámetros de las secuencias

N = 1000; %Largo de la secuencia

%% Generación de las seuencias

A = rand(1,N); %Genera una serie de numeros aleatorios (0-1) de largo N

a_0 = A; %Orden original

a_1 = sort(A); %Ordena de menor a mayor

a_2 = flip(A); %Invierte el orden

%% Sumatoria de las secuencias

s_0 = sum(a_0); %Suma en el orden original

s_1 = sum(a_1); %Suma de menor a mayor

s_2 = sum(a_2); %Suma en orden invertido

%% Impresión de resultados

fprintf('s_0: %.20f\n',s_0); %Resultado en el orden original

fprintf('s_1: %.20f\n',s_1); %Resultado en el orden menor a mayor

fprintf('s-2: %.20f\n',s_2); %Resultado en el orden invertido

%------------- END OF CODE ------------------------------------------------
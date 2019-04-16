%Script_TestConv - Verifica el correcto funcionamiento de Func_MyConv
%Genera un escal�n x(t) y un vector h(t) y verifica que FUNC_MyConv de el
%mismo resultado que la funci�n conv() de MATLAB. Adem�s, se verifica que
%sea conmutable (x*h = h*x)
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

%% Par�metros de x(t)

N = 4; %Cantidad de muestras

Amp_x = 1; %Amplitud de x(t)

%% Generaci�n de x(t)

x_t = int32(Amp_x.*ones(1,N)); %Genera un escal�n de largo x y amplitud Amp
class(x_t) 

%% Generaci�n de h(t)

h_t = int32([5,3,1]);
class(h_t)

%% C�lculo de x*h

y1_t = Func_MyConv(x_t,h_t); %Usando la convoluci�n propia
class(y1_t)

y2_t = conv(x_t,h_t); %Usando la convoluci�n de matlab
class(y2_t)

%% Grafica los resultados

figure()
subplot(4,1,1);
stem(x_t); %Grafica x(t)
subplot(4,1,2);
stem(h_t); %Gr�fica h(t)
subplot(4,1,3);
stem(y1_t); %Gr�fica la convoluci�n propia
subplot(4,1,4);
stem(y2_t); %Gr�fica la convoluci�n de matlab

%% Verifica la conmutabilidad de la convoluci�n

y1_t = Func_MyConv(x_t,h_t);

y2_t = Func_MyConv(h_t,x_t);

%% Gr�fica los resultados

figure()
h1 = subplot(2,1,1);
stem(y1_t); %Grafica x(t)
h2 = subplot(2,1,2);
stem(y2_t); %Gr�fica h(t)

%------------- END OF CODE ------------------------------------------------

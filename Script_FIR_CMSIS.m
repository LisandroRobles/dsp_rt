%% Preparación del entorno

clc; %Borra la consola

clear; %Borra el workspace

close all; %Cierra todas las figuras abiertas

%% Parámetros de la señal (CUADRADA)

blockSize = 512; % Largo de la señal [muestras]

fs = 1024; % Frecuencia de muestreo [Hz]

Ts = 1/fs; % Período de muestreo [seg]

t = 0:Ts:(blockSize-1)*Ts; %Vector temporal [seg]

fo = 10; % Frecuencia fundamental de la señal [Hz]

To = 1/fo; % Periodo de la señal [seg]

duty = 50; % Ciclo de actividad [%]

SNR = 40; % Relación señal a ruido [dB]

Vmax = 2; % [V]

Vmin = 1; % [V]

%% Parametros del filtro (MOVING AVERAGE)

numTaps = 64; % Cantidad de coeficientes del filtro

% pCoeffs = [-0.000095,-0.000705,-0.001924,-0.003957,-0.006526,-0.008932,...
%     -0.010130,-0.009127,-0.005515,0.000075,0.005904,0.009620,0.009230,...
%     0.004197,-0.003908,-0.011652,-0.015015,-0.011284,-0.000750,0.012718,...
%     0.022783,0.023252,0.011244,-0.010506,-0.033485,-0.045851,-0.036837,...
%     -0.001478,0.056356,0.124093,0.184026,0.219167,0.219167,0.184026,...
%     0.124093,0.056356,-0.001478,-0.036837,-0.045851,-0.033485,-0.010506,...
%     0.011244,0.023252,0.022783,0.012718,-0.000750,-0.011284,-0.015015,...
%     -0.011652,-0.003908,0.004197,0.009230,0.009620,0.005904,0.000075,...
%     -0.005515,-0.009127,-0.010130,-0.008932,-0.006526,-0.003957,...
%     -0.001924,-0.000705,-0.000095];

pCoeffs = (1/(numTaps))*ones(1,numTaps); % Coeficientes del filtro (double)

%% Parámetros para convertir a punto fijo (Q1.15)

numbits = 15; %15 bits para la parte fraccional (Q1.15)

Fconv = (2^numbits); %Factor de escala para pasar de double a Q1.15

%F_div = int64(2^(numbits + log2(N))); %El log2 esta de más, pero se debe
%considerar (tiene que ver con la saturacion del acumulador)
%F_div = int32(2^numbits);

%% Generación de la señal

% Genera una cuadrada con los parámetros especificados
%x = ((Vmax - Vmin)/2)*square(2*pi*fo.*t,duty) + ((Vmax + Vmin)/2);

x = 1.5*ones(1,blockSize);

n = Func_Wgn(x,SNR); % Genera la señal de ruido

pSrc = (x + n); % Agrega ruido a la señal

%% Aplicación del filtro de CMSIS

pSrc_Q15 = Func_Adc_Stm32f407(pSrc,0); % Cuantiza la señal con el ADC

pCoeffs_Q15 = int16(round(pCoeffs*Fconv)); % Pasa coeficientes  a Q15

% Inicializa el filtro con sus parámetros
S = Func_arm_fir_init_q15(numTaps,fliplr(pCoeffs_Q15),blockSize); 

[pDst_Q15] = Func_arm_fir_q15(S,pSrc_Q15,blockSize); % Aplica el filtro

%pDst_CMSIS = double(pDst_Q15)/double(Fconv);

pDst_DAC = Func_Dac_Stm32f407(pDst_Q15); % Saca la señal por el DAC

%% Aplicación del filtro de MATLAB

b = pCoeffs; % Numerador de la transferencia

a = 1; % Denominador de la transferencia

pDst_MATLAB = filter(b,a,pSrc); % Aplica el filtro

%% Cálculo del error

e = pDst_MATLAB - pDst_DAC;

u = mean(e);

v = var(e);

%% Presentación de resultados

figure()
subplot(4,1,1);
plot(t,pSrc); %Grafica h(t) cuantficado
axis('tight');
subplot(4,1,2);
plot(t,pDst_DAC); %Grafica h(t) cuantficado
axis('tight');
subplot(4,1,3);
plot(t,pDst_MATLAB); %Grafica h(t) cuantficado
axis('tight');
subplot(4,1,4);
plot(t,e); %Grafica h(t) cuantficado
axis('tight');
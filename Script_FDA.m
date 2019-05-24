clc;
clear;
close all;

%H = Func_LowPassFilter();

%H = H.Numerator;

numtaps = 64;

H = (1/numtaps)*ones(1,numtaps);

H_Q15 = round(H*(2^15));

fprintf('%d,',H_Q15);
function [ s ] = Func_Dac_Stm32f407(sq)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Vref_high = 3; %Vref+ del ADC [V]

Vref_low = 0; %Vref- del ADC [V]

n = 12; %Cantidad de bits

q = (Vref_high - Vref_low)/((2^n)-1); %V/cuenta del ADC

s = double(sq)*double(q);

end


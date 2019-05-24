function [sq] = Func_Adc_Stm32f407(s,alignment)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Vref_high = 3; %Vref+ del ADC [V]

Vref_low = 0; %Vref- del ADC [V]

n = 12; %Cantidad de bits

q = (Vref_high - Vref_low)/((2^n)-1); %V/cuenta del ADC

s(s > Vref_high) = Vref_high; %Satura todos los valores por encima de Vref

s(s < Vref_low) = Vref_low; %Satura todos los valores por debajo de Vref

sq = int16(round(s/q));

if alignment == 1
   sq = bitshift(sq,4); 
end

end


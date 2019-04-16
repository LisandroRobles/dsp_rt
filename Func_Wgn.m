function [n_t] = Func_Wgn(x_t,SNR)
%Func_Wgn - Genera ruido blanco gaussiano n(t) para un dado SNR.
%A partir de una señal x(t), se genera ruido blanco gaussiano n(t) con
%varianza tal que se cumpla la SNR especificada:
%
%   SNR = 10*log10(var(x(t))/var(n(t)))
%
% Syntax:  [n_t] = Func_wgn(x_t,SNR)
%
% Inputs:
%    x_t - Señal de 1xN.
%    SNR - Relación señal ruido entre x_t y n_t en dB.
%
% Outputs:
%    n_t - Señal de 1xN
%
% Example: 
%    x_t = ones(1,10);
%    SNR = 40;
%    n_t = Func_Wgn(x_t,SNR);
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lisandro Robles
% email address: LisandroRobles1@gmail.com  
% Last revision: 27/03/2019

%------------- BEGIN CODE -------------------------------------------------

N = size(x_t,2); %Obtiene el largo de x(t)

var_x_t = var(x_t); %Varianza de la señal x(t)

var_n_t =(10^(-SNR/10)).*var_x_t; %Obtiene la varianza que debe tener n(t)

n_t = sqrt(var_n_t).*randn(N,1)'; %Crea n(t):n2 = k*n1 -> v(n1) = k^2*v(n2)

%------------- END OF CODE ------------------------------------------------

end


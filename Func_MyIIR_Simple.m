function [y_t] = Func_MyIIR_Simple(x_t,a,b)
%Func_MyIIR_Simple - Implementa un IIR de orden1
%Implementa el siguiente filtro IIR de orden 1 sobre una señal x[n]:
%
%   y[n] = a*x[n] + b*y[n-1]
%
% Syntax:  [y_t] = Func_MyConv(x_t,a,b)
%
% Inputs:
%    x_t - Señal de entrada. 1xN
%    a   - Coeficiente directo.
%    b   - Coeficiente de realimentación.
%
% Outputs:
%    y_t - Señal de salida. 1xN
%
% Example: 
%    x_t = ones(1,10);
%    a = 1;
%    b = 0.5;   
%    y_t = Func_MyII_Simple(x_t,a,b);
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lisandro Robles
% email address: LisandroRobles1@gmail.com  
% Last revision: 27/03/2019

%------------- BEGIN CODE --------------

xN = size(x_t,2); %Obtiene el largo de la señal

y_t = zeros(1,xN); %Inicializa a cero el vector de salida

anterior = 0; %Variable donde se almacenara x[n-1]
for i = 1:xN %Para cada posición del vector de salida
    
    y_t(1,i) = a*x_t(1,i) + b*anterior; %y[i] = a*x[i] + bx[i-1]

    anterior = y_t(1,i); %Almacena el valor actual para el próximo ciclo
    
end

%------------- END OF CODE --------------

end
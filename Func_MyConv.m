function [y_t] = Func_MyConv(x_t,h_t)
%Func_Wgn - Implementa la convoluci�n x(t)*h(t)
%
% Syntax:  [y_t] = Func_MyConv(x_t,h_t)
%
% Inputs:
%    x_t - Se�al de 1xN.
%    h_t - Se�al de 1xM.
%
% Outputs:
%    y_t - Convoluci�n entre x_t y h_t.Se�al de 1x(M + N -1)
%
% Example: 
%    x_t = ones(1,10);
%    h_t = ones(1,2);   
%    y_t = Func_MyConv(x_t,h_t);
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lisandro Robles
% email address: LisandroRobles1@gmail.com  
% Last revision: 27/03/2019

%------------- BEGIN CODE -------------------------------------------------

xN = size(x_t,2); %Largo de x
hN = size(h_t,2); %Largo de h

yN = xN + hN -1; %Largo de la se�al de salida

x_ext_t = [zeros(1,hN-1) x_t zeros(1,hN-1)]; %Evitar condiciones de borde

y_t = int64(zeros(1,yN)); %Inicializa el buffer de salida

h_t = fliplr(h_t); %Invierte el vector h_t

for i = 1:yN %Para cada punto de y(t)

    acum = int64(0); %Inicializa el acumulador para este punto
    
    for j = 1:hN %Para cada uno de los puntos de h(t) 
    
        acum = acum + x_ext_t(1,i + j -1).*h_t(1,j); %Suma el acumulador
    
    end
    
    y_t(1,i) = acum; %Asigna el resultado actual a y(t)

end

%------------- END OF CODE ------------------------------------------------

end


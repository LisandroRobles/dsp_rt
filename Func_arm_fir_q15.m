function [pDst] = Func_arm_fir_q15(S,pSrc,blockSize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

pDst = int16(zeros(1,length(pSrc))); % Inicializa el vector de salida a 0

pState = S.pState; % Obtiene el vector de estado
pCoeffs = S.pCoeffs; % Obtiene el vector de coeficientes
numTaps = S.numTaps; % Obtiene el numero de coeficientes

pStateCurrentIndex = numTaps; % Los primeros (numtaps-1) son cero
pSrcIndex = 1; % Indice para recorrer pSrc
pDstIndex = 1; % Indice para recorrer pDst
pStateIndex = 1;

blockCnt = bitshift(blockSize,-2); % Procesara de a 4 muestras

% Para cada grupo de 4 muestras
while blockCnt > 0
    
    % Copia 4 nuevas muestras en el buffer de estado
    pState(pStateCurrentIndex) = pSrc(pSrcIndex);
    pState(pStateCurrentIndex + 1) = pSrc(pSrcIndex + 1);
    pState(pStateCurrentIndex + 2) = pSrc(pSrcIndex + 2);
    pState(pStateCurrentIndex + 3) = pSrc(pSrcIndex + 3);
    pStateCurrentIndex = pStateCurrentIndex + 4;
    pSrcIndex = pSrcIndex + 4;
    
    % Pone los acumuladores a cero
    acc0 = int64(0);
    acc1 = int64(0);
    acc2 = int64(0);
    acc3 = int64(0);
    
    % Pone el indice de coeficientes a 1 (el más antiguo temporalmente)
    pb = 1;

    % Indice que apunta a la muestra más antigua para este bloque
    px1 = pStateIndex;
    
    % Procesara de a 4 coeficientes
    tapCnt = bitshift(numTaps,-2);
    
    % Para cada grupo de 4 coeficientes
    while tapCnt > 0
       
        acc0 = acc0 + (int64(pCoeffs(pb))*int64(pState(px1)))...
        + (int64(pCoeffs(pb + 1))*int64(pState(px1 +1)));
        
        acc1 = acc1 + (int64(pCoeffs(pb))*int64(pState(px1 + 1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 + 2)));
        
        px1 = px1 + 2;
        
        acc2 = acc2 + (int64(pCoeffs(pb))*int64(pState(px1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 +1)));
        
        acc3 = acc3 + (int64(pCoeffs(pb))*int64(pState(px1 + 1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 + 2)));
        
        pb = pb + 2;
        
        acc0 = acc0 + (int64(pCoeffs(pb))*int64(pState(px1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 +1)));
        
        acc1 = acc1 + (int64(pCoeffs(pb))*int64(pState(px1 + 1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 + 2)));
        
        px1 = px1 + 2;

        acc2 = acc2 + (int64(pCoeffs(pb))*int64(pState(px1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 +1)));
        
        acc3 = acc3 + (int64(pCoeffs(pb))*int64(pState(px1 + 1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 + 2)));
        
        pb = pb + 2;
        
        tapCnt = tapCnt - 1;
        
    end

    % Si la cantidad de taps del filtro no es multiplo de 4,computa los
    % taps que faltan. Siempre serán 2 porque el largo del filtro es entero
    if mod(numTaps,4) ~= 0
       
        acc0 = acc0 + (int64(pCoeffs(pb))*int64(pState(px1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 +1)));
        
        acc1 = acc1 + (int64(pCoeffs(pb))*int64(pState(px1 + 1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 + 2)));
        
        px1 = px1 + 2;

        acc2 = acc2 + (int64(pCoeffs(pb))*int64(pState(px1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 +1)));
        
        acc3 = acc3 + (int64(pCoeffs(pb))*int64(pState(px1 + 1)))...
            + (int64(pCoeffs(pb + 1))*int64(pState(px1 + 2)));
                
    end
    
    % Almacena 4 nuevas salidas en pDst
    % El resultado de los acumuladores esta en 34.30, primero descarta los
    %15 bits menos significativos quedando en 34.15 y luego satura a 1.15
    pDst(pDstIndex) = int16(bitshift(acc0,-15));
    pDst(pDstIndex + 1) = int16(bitshift(acc1,-15));
    pDst(pDstIndex + 2) = int16(bitshift(acc2,-15));
    pDst(pDstIndex + 3) = int16(bitshift(acc3,-15));
    
    pDstIndex = pDstIndex + 4; % Incrementa el indice del vector de salida 
    
    pStateIndex = pStateIndex + 4; % Indice a la muestra más vieja
    
    blockCnt = blockCnt - 1; % Termino de procesar 4 muestras de entrada 
    
end

end


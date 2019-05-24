function [ S ] = Func_arm_fir_init_q15(numTaps,pCoeffs,blockSize)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    S.numTaps = numTaps;
    
    S.pCoeffs = int16(pCoeffs);
    
    S.pState = int16(zeros(1,numTaps + blockSize));

end


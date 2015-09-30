function [ weightMatrix ] = SetHebbsWeights( patterns )
%SETHEBBSWEIGHTS

nBits = size(patterns,1);

% compute W matrix in a smart way
weightMatrix = 1/nBits*(patterns*patterns');

% set diagonal elements to zero
weightMatrix(logical(eye(size(weightMatrix)))) = 0;

end

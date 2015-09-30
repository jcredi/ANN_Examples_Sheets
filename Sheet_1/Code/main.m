clear
clc

nBits = 100;
nPatterns = 1;

randomPatterns = GenerateRandomPatterns( nBits, nPatterns );
weightMatrix = SetHebbsWeights(randomPatterns);

[net, f] = CheckPatternStablity( weightMatrix, randomPatterns(:,1), 10 );
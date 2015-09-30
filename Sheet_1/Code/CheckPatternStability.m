function [networkEvolution, figureHandle] = CheckPatternStability( weightMatrix, inputPattern, runTime )
%CHECKPATTERNSTABILITY

nBits = length(weightMatrix);
networkEvolution = zeros(nBits, runTime+1);

networkEvolution(:,1) = inputPattern;

for t = 2:runTime+1
    networkEvolution(:,t) = DeterministicSyncUpdate(networkEvolution(:,t-1),weightMatrix);
end

figureHandle = imagesc(networkEvolution);


end


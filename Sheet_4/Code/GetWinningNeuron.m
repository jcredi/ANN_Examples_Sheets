function iWinning = GetWinningNeuron(inputPattern, kohonenWeights)

nNodes = size(kohonenWeights,1);
activationFunction = zeros(nNodes,1);

for j = 1:nNodes
  distance = sqrt((inputPattern(1)-kohonenWeights(j,1))^2 + ...
    (inputPattern(2)-kohonenWeights(j,2))^2);
  activationFunction(j) = exp(-distance/2);
end

[~,iWinning] = max(activationFunction);

end
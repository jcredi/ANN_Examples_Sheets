function updatedWeights = UpdateWeights(weights, iWinning, inputPattern,...
  etaKohonen, neighbourhoodMatrix)

nNodes = size(weights,1);
deltaWeights = zeros(nNodes,2);

for iNode = 1:nNodes
  tmpDiff = inputPattern-weights(iNode,:);
  deltaWeights(iNode,:) = etaKohonen*neighbourhoodMatrix(iNode,iWinning).*tmpDiff;
end

updatedWeights = weights + deltaWeights;

end
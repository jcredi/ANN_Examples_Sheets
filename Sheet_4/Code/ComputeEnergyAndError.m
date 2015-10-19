function [energy, classificationError] = ComputeEnergyAndError(patterns,...
  patternClasses, kohonenWeights, perceptronWeights, beta)
%% ComputeEnergyAndError    

nPatterns = size(patterns, 1);
nKohonenNodes = size(kohonenWeights,1);

tmpOutput = zeros(nPatterns,1);

for iPattern = 1:nPatterns
  inputPattern = patterns(iPattern,:);
  
  [~, tmpOutput(iPattern)] = RunClassifier(inputPattern, kohonenWeights, ...
    nKohonenNodes, perceptronWeights, beta);
end

% compute energy
tmpEnergy = (patternClasses - tmpOutput).^2;
energy = 0.5*sum(tmpEnergy);

% compute classification error
tmpError = abs(patternClasses - sign(tmpOutput)); 
classificationError = 0.5/nPatterns*sum(tmpError);

end
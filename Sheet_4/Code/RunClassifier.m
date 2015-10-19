function [gaussianActivation, output] = RunClassifier(inputPattern, ...
  kohonenWeights, nKohonenNodes, perceptronWeights, beta)
%% RunClassifier

% run Kohonen network
gaussianActivation = zeros(nKohonenNodes+1,1);
for j = 1:nKohonenNodes
  distance = sqrt((inputPattern(1)-kohonenWeights(j,1))^2 + ...
    (inputPattern(2)-kohonenWeights(j,2))^2);
  gaussianActivation(j) = exp(-distance/2);
end
gaussianActivation = gaussianActivation./sum(gaussianActivation); % normalise
gaussianActivation(end) = -1; % dummy neuron (for threshold)

% run perceptron
output = tanh(beta*(perceptronWeights*gaussianActivation));
  
end
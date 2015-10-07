function [classificationError, energy] = ComputeErrorAndEnergy(...
    weightsCell, beta, inputPatterns, trueOutputs)
%COMPUTEERRORANDENERGY

nPatterns = size(inputPatterns, 1);
nOutputs = size(trueOutputs, 2);

perceptronOutputs = zeros(nPatterns, nOutputs);

for mu = 1:nPatterns
  perceptronState = RunPerceptron(inputPatterns(mu,:)', weightsCell, beta);
  perceptronOutputs(mu,:) = perceptronState{1,end};
end

tmpArrayError = abs(trueOutputs - sign(perceptronOutputs));
tmpArrayEnergy = (trueOutputs - perceptronOutputs).^2;
  
classificationError = 0.5/nPatterns*sum(tmpArrayError(:));
energy = 0.5*sum(tmpArrayEnergy(:));

end
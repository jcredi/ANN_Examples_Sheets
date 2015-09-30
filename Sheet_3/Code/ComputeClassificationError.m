function [classificationError] = ComputeClassificationError(...
    desiredOutputs, obtainedOutputs)
%COMPUTECLASSIFICATIONERROR

p = numel(desiredOutputs);

tmpVector = abs(desiredOutputs - sign(obtainedOutputs));
classificationError = 1/(2*p)*sum(tmpVector);

end


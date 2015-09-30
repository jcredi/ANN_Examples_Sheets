function [normalizedTrainingPatterns, normalizedValidationPatterns] = ...
    NormalizeData(trainingPatterns, validationPatterns)
%NORMALIZEDATA

n = size(trainingPatterns,1);

tmpArray = [trainingPatterns; validationPatterns];
tmpArray(:,1) = (tmpArray(:,1) - mean(tmpArray(:,1))) ...
    ./std(tmpArray(:,1));
tmpArray(:,2) = (tmpArray(:,2) - mean(tmpArray(:,2)))...
    ./std(tmpArray(:,2));

normalizedTrainingPatterns = tmpArray(1:n,:);
normalizedValidationPatterns = tmpArray(n+1:end,:);

end
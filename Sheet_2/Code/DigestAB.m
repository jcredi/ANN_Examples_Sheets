function [ sortedC ] = DigestAB( sequenceA, sequenceB)
%DIGESTAB
%   [ sortedC ] = DigestAB( sequenceA, sequenceB, L ) returns the sorted
%   sequence c that would result from double digestion if sequenceA and
%   sequenceB were the correct fragment sequences. L is the sum of the
%   fragments' lengthts.

% Compute vectors of cumulative sums
cumulatedA = cumsum(sequenceA);
cumulatedB = cumsum(sequenceB);

% Concatenate cumsums and sort the resulting vector
sortedCumulatedC = union(cumulatedA, cumulatedB);

% Compute difference between adjacent elements
sequenceC = diff(sortedCumulatedC);

% Append first element of cumulative sum
sequenceC = [sortedCumulatedC(1) sequenceC];

% Sort resulting vector in descending order
sortedC = sort(sequenceC,'descend');

end


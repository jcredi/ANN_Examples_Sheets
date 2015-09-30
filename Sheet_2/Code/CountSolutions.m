function [structDiffSolutions, nSolutions] = CountSolutions( outputData )
%COUNTSOLUTIONS

nRuns = length(outputData);
nA = numel(outputData(1).a);
nB = numel(outputData(1).b);

aSequences = extractfield(outputData, 'a');
aSequences = reshape(aSequences',[nA nRuns])';

bSequences = extractfield(outputData, 'b');
bSequences = reshape(bSequences',[nB nRuns])';

% Remove non-optimal solutions
isOptimal = cell2mat(extractfield(outputData,'isOptimal'))';
aSequences(~isOptimal,:) = [];
bSequences(~isOptimal,:) = [];

solutionsMatrix = [aSequences, bSequences];

differentSolutions = unique(solutionsMatrix,'rows');

nSolutions = size(differentSolutions, 1);

structDiffSolutions = repmat(struct('a', [] ,'b', []), nSolutions, 1);
    
for k = 1:nSolutions
    structDiffSolutions(k).a = differentSolutions(k,1:nA);
    structDiffSolutions(k).b = differentSolutions(k,nA+1:end);
end

end


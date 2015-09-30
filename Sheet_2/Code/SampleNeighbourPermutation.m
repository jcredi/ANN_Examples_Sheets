function newPermutation = SampleNeighbourPermutation( permutation )
%SAMPLENEIGHBOURPERMUTATION
%	newPermutation = SampleNeighbourPermutation( permutation ) returns an
%	output vector containing the same elements as the input vector, in the
%	same order except for 2 elements, which are swapped.

newPermutation = permutation;

toSwap = randperm(numel(permutation),2);

newPermutation(toSwap) = permutation(fliplr(toSwap));

end

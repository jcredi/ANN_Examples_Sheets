function [ orderParam ] = ComputeOrderParam( storedPattern, networkState )
%COMPUTEORDERPARAM

orderParam = 1/length(storedPattern)*(storedPattern'*networkState);

end


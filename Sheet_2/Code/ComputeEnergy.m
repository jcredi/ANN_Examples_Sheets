function [ H ] = ComputeEnergy( c, cTilde )
%COMPUTEENERGY
%	H = ComputeEnergy( c, cTilde ) returns the energy function H(S^(k))
%	evaluated at the sequences c, cTilde

maxIndex = min(numel(c),numel(cTilde));
c = c(1:maxIndex);
cTilde = cTilde(1:maxIndex);

H = sum(((c-cTilde).^2)./c);

end


function [ randomPatterns ] = GenerateRandomPatterns( nBits, nPatterns )

if nargin < 2
    nPatterns = 1;
end

randomPatterns = 2*round(rand(nBits,nPatterns))-1;

end

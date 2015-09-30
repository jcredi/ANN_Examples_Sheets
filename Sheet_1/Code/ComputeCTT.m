function [ crossTalkTerms ] = ComputeCTT( patterns )
%COMPUTECTT

nBits = size(patterns,1);
nPatterns = size(patterns,2);
crossTalkTerms = zeros(size(patterns));

muVals = 1:nPatterns;

for k= 1:nBits

    %create temp matrix without j-th row (logical indexing for performance)
    index = true(1, size(patterns, 1));
    index(k) = false;
    tempMatrix = patterns(index,:);
    
    for nu = 1:nPatterns
        
        % allowed values of mu (all but mu=nu)
        allowedMus = muVals(muVals~=nu);
        
        for mu = allowedMus
            crossTalkTerms(k,nu) = crossTalkTerms(k,nu) + ...
                patterns(k,mu)*sum(tempMatrix(:,nu).*tempMatrix(:,mu));
        end
    end
end

% do not forget to multiply element-wise and divide by N
crossTalkTerms = -1/nBits*(crossTalkTerms.*patterns);
end

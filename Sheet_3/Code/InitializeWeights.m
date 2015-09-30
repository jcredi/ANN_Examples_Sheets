function weightsCell = InitializeWeights(neuronsInLayers, wR, bR)
%INITIALIZEWEIGHTS

% wR = weightRange = 0.2;
% bR = biasRange = 1.0;

L = size(neuronsInLayers,2)-1;
weightsCell = cell(1,L);

for l = 1:L
    N = neuronsInLayers(l);
    M = neuronsInLayers(l+1);

    W = [-wR + 2*wR.*rand(M,N), -bR + 2*bR.*rand(M,1)];
    weightsCell{l} = W;
end

end
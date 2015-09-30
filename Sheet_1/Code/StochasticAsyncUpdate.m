function [ newNetworkState ] = StochasticAsyncUpdate( networkState, weightMatrix, beta )
%STOCHASTICASYNCUPDATE

% Pick bit to update uniformly at random
nBits = length(weightMatrix);
ii = randi(nBits);

% Evaluate Boltzmann factor
b_ii = weightMatrix(ii,:)*networkState;
boltz = 1/(1+exp(-2*beta*b_ii));

% Update bit i
newNetworkState = networkState;
if rand() < boltz
    newNetworkState(ii) = +1;
else
    newNetworkState(ii) = -1;
end

end

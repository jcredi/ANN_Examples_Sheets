function [ newNetworkState ] = DeterministicSyncUpdate( networkState, weightMatrix )
%DETERMINISTICSYNCUPDATE

newNetworkState = sign(weightMatrix*networkState);
% ...as easy as that!

end


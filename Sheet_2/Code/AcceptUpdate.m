function [ acceptUpdate ] = AcceptUpdate( beta, newH, oldH )
%ACCEPTUPDATE
%	acceptUpdate = AcceptUpdate( beta, newH, oldH ) returns the logical 
%   value 1 (true) if the proposed update with energy newH is accepted, 0
%   (false) otherwise.

deltaH = newH - oldH;

% Compute acceptance probability
if deltaH > 0
    acceptanceProbability = exp(-beta*deltaH);
else
    acceptanceProbability = 1;
end

% Check whether the update is accepted or not
if rand < acceptanceProbability
    acceptUpdate = true;
else
    acceptUpdate = false;
end

end
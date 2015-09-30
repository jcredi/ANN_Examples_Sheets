function [errorProbs] = CheckBitStability( nBits, maxNPatterns, nSamples, patternID, bitID )
%CHECKBITSTABILITY

% initialize 2D logical array of errors
boolErrors = false(maxNPatterns,nSamples);

h = waitbar(0,'Please wait...');

for nPatterns = 1:maxNPatterns % run over different p/N ratios
    
    parfor ii = 1:nSamples

        % generate nPatterns new random patterns and train network
        randomPatterns = GenerateRandomPatterns( nBits, nPatterns );
        weightMatrix = SetHebbsWeights(randomPatterns);

        % feed pattern # patternID and check stability of bit # bitID
        outputPattern = DeterministicSyncUpdate(randomPatterns(:,patternID),weightMatrix);
        if outputPattern(bitID,patternID) ~= randomPatterns(bitID,patternID)
            boolErrors(nPatterns,ii) = true;
        end
    end

    waitbar(nPatterns/maxNPatterns,h)
end
close(h);

errorProbs = mean(boolErrors,2); % average over samples

end


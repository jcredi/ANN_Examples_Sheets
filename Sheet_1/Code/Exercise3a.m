%EXERCISE3A
clear 

% ======================================================================= %
% Parameters
% ======================================================================= %

noiseMax = 8; % using integer because of parfor loop
nBits = 500; % use 500 and 1000
nSweeps = 10000;
patternID = 1; % pattern to feed
alphaValues = [0.025, 0.05, 0.1, 0.125, 0.15, 0.2];
burnIn = 1000;

% ======================================================================= %

% Initializations
orderParamDataset = zeros(noiseMax,length(alphaValues),nSweeps);
alphaID = 1;

h = waitbar(0, 'Please wait...');

for alpha = alphaValues
    tic

    % compute number of patterns according to alpha
    nPatterns = fix(nBits*alpha);

    % initialize local variable to temporary store m values
    orderParams = zeros(noiseMax,nSweeps);

    % parallel loop over noise
    parfor noise = 1:noiseMax

        beta = 10/noise;

        % generate random patterns and set weigths
        randomPatterns = GenerateRandomPatterns( nBits, nPatterns );
        weightMatrix = SetHebbsWeights( randomPatterns );

        % Feed network with pattern # patternID (default 1)
        networkState = randomPatterns(:, patternID);
        % and define pattern to compare with the network state
        storedPattern = randomPatterns(:,patternID); 

        for sweep = 1:nSweeps % run MCMC sweeps

            for tt = 1:nBits % and in each sweep update the network nBits times
                             % (so that on average each bit is updated once)
                networkState = StochasticAsyncUpdate( networkState, weightMatrix, beta );
            end

            % then compute and store order parameter
            orderParams(noise,sweep) = ComputeOrderParam(storedPattern, networkState);
        end
    end

    % finally store order parameter samples in an outer 3D array
    orderParamDataset(:,alphaID,:) = orderParams;
    alphaID = alphaID +1;
    
    waitbar(alphaID/length(alphaValues),h);
    toc
end
close(h);

% smoothing
for ii = 1:noiseMax
    for jj = 1:length(alphaValues)
        orderParamDataset(ii,jj,:) = smooth(squeeze(orderParamDataset(ii,jj,:)),100);
    end
end

% remove initial values (burnin)
dataset = dataset(:,:,burnIn+1:end);

meanValues = (mean(dataset,3));
lowerQuantiles = (quantile(dataset,0.05,3));
upperQuantiles = (quantile(dataset,0.95,3));
errors = max(upperQuantiles-meanValues,meanValues-lowerQuantiles);

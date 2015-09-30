%EXERCISE3B
clear 
tic

% ======================================================================= %
% Parameters
% ======================================================================= %

noise = 0.1; % depending on this value, set alpha values below
howManyPoints = 5; % points to sample and then use for interpolation
alphaValues = linspace(0.125,0.15,howManyPoints); % alpha window of interest found in previous exercise (DEPENDS on noise!!)
nBits = 500; % use 500 and 1000
nSweeps = 1000;
patternID = 1; % pattern to feed
burnIn = 500;

% ======================================================================= %

% Initializations
orderParamDataset = zeros(length(alphaValues),nSweeps);
beta = 1/noise;

parfor alphaID = 1:howManyPoints
    
    alpha = alphaValues(alphaID);
    % compute number of patterns according to alpha
    nPatterns = max(1,fix(nBits*alpha));

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
        orderParamDataset(alphaID,sweep) = ComputeOrderParam(storedPattern, networkState);
    end
    
end

% remove initial values
nchorderParamDataset = orderParamDataset(:,burnIn+1:end);

% compute mean values
meanOrderParam = mean(orderParamDataset,2);

% interpolation
xq = linspace(min(alphaValues),max(alphaValues),5*howManyPoints);
vq2 = interp1(alphaValues,meanOrderParam,xq,'spline');
tmp = abs(vq2-0.5);
[val , idx] = min(tmp);

alphaCrit = xq(idx)
error = alphaValues(2)-alphaValues(1)

toc


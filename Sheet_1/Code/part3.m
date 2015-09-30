%PART3

clear
clc
tic

% ======================================================================= %
% Parameters
% ======================================================================= %

nBits = 500;
nPatterns = 10;
noise = 0.5;
tMax = 100000;
nRuns = 5;
patternID = 1;

% ======================================================================= %


% Initializations
orderParams = zeros(nRuns,tMax);
fig = figure;

% Preliminary operations
beta = 1/noise;
randomPatterns = GenerateRandomPatterns( nBits, nPatterns );
weightMatrix = SetHebbsWeights( randomPatterns );
storedPattern = randomPatterns(:,patternID); 

for jj = 1:nRuns
    
    % Re-initialise network at each run
    networkState = randomPatterns(:, patternID);
   
    message = ['Please wait...                             Run ' num2str(jj) ' of ' num2str(nRuns)];
    h = waitbar(0, message);
    
    for tt = 1:tMax

        % compute order parameter
        orderParams(jj,tt) = ComputeOrderParam(storedPattern, networkState);

        % update network
        networkState = StochasticAsyncUpdate( networkState, weightMatrix, beta );

        waitbar(tt/tMax,h);
    end
    close(h);
    
    figure(fig);
    plot(orderParams(jj,:),'LineWidth',1);
    hold on;
    
end

% Plot settings
set(gcf,'color','w');
f1 = plot(nan); f2 = plot(nan); f3 = plot(nan); f4 = plot(nan); f5 = plot(nan);
legend([f1,f2,f3,f4,f5],'Run 1', 'Run 2', 'Run 3', 'Run 4', 'Run 5')
pbaspect([1.618 1 1])
hold off;

toc

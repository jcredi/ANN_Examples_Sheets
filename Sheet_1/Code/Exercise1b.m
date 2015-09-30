%EXERCISE1B
clear
clc
tic

% ======================================================================= %
% Parameters
% ======================================================================= %

nBits = 100;
nSamples = 10000;
maxNPatterns = 100;
patternID = 1; % first pattern by default
bitID = 1; % first bit by default

% ======================================================================= %


[errorProbs] = CheckBitStability( nBits, maxNPatterns, nSamples, patternID, bitID );

% plot estimated probabilities
alpha = (1:maxNPatterns)/maxNPatterns;
plot(alpha,errorProbs,'bo');
hold on

% plot theoretical error probabilities
theorVals = 1/2*(1-erf(sqrt(1./(2.*alpha))));
plot(alpha,theorVals,'r');
hold off

% plot settings
set(gcf,'color','w')
xlabel('\alpha = p/N');
ylabel('P_{err}');
pbaspect([1.618 1 1]);
set(gca,'fontsize', 24);


toc
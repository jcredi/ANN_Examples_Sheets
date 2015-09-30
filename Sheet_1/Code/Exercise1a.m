%EXERCISE1A
clear
clc
tic

% ======================================================================= %
% Parameters
% ======================================================================= %

nBits = 50;
nPatterns = 10;
nSamples = 4000;

% ======================================================================= %

% Initializations
crossTalkTerms = zeros(nBits, nPatterns, nSamples);

% Main loop
h = waitbar(0, 'Please wait...');
for sample = 1:nSamples
    
    randomPatterns = GenerateRandomPatterns( nBits, nPatterns );
    crossTalkTerms(:,:,sample) = ComputeCTT(randomPatterns);
    
    waitbar(sample/nSamples,h);
end
close(h);

[h1 , f1] = PrettyPlotCTT(crossTalkTerms(:), nPatterns/nBits);
[h2 , f2] = LogPlotCTT(crossTalkTerms(:), nPatterns/nBits);

toc
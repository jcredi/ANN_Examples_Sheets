rclear
clc
tic

nBits = 1000;
nPatterns = 200;

randomPatterns = GenerateRandomPatterns( nBits, nPatterns );
crossTalkTerms = ComputeCTT(randomPatterns);

[h1 , f1] = PrettyPlotCTT(crossTalkTerms, nPatterns/nBits, 10);

toc
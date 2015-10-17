clear; clc; close all;

%% Parameters
nIterationsKohonen = 100000;
etaKohonen = 0.02;
sigma = 0.5; % starting value
%sigmaMin = 0.1;
nKohonenNodes = 20;

%% Load data
tmpData = importdata('../Data/data_classify.txt');
patternClass = tmpData(:,1);
patterns = tmpData(:,2:end);
nPatterns = size(patterns, 1);

%% Initialisations
kohonenWeights = -1 + 2*rand(nKohonenNodes,2);

% trick for speed
tmp = 1:nKohonenNodes;
A = repmat(tmp,nKohonenNodes,1)-repmat(tmp',1,nKohonenNodes);
A = triu(A) + triu(A)';
neighbourhoodMatrix = exp(-(A.^2)/(2*sigma^2));

%% Initialise plot
figure();
hold on
dataPlot = plot(patterns(:,1),patterns(:,2),'.','MarkerSize',12);
weightsPlot = plot(kohonenWeights(:,1),kohonenWeights(:,2),'x');
set(weightsPlot,'LineWidth',2,'MarkerSize',20);   
hold off

%% Competitive training loop
tic;
for iKohonen = 1:nIterationsKohonen
    
  iPattern = randi(nPatterns); 
  inputPattern = patterns(iPattern,:);
  
  iWinning = GetWinningNeuron(inputPattern, kohonenWeights);
  kohonenWeights = UpdateWeights(kohonenWeights, iWinning, inputPattern,...
  etaKohonen, neighbourhoodMatrix);
    
  if mod(iKohonen,1000) == 0
    set(weightsPlot,'XData',kohonenWeights(:,1));
    set(weightsPlot,'YData',kohonenWeights(:,2));
    drawnow;
  end
end
toc;

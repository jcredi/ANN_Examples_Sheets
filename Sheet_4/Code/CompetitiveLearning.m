function kohonenWeights = CompetitiveLearning(patterns, nKohonenNodes, ...
  sigmaNeighbourhoodFunction, nIterationsKohonen, etaKohonen)
%% CompetitiveLearning

nPatterns = size(patterns, 1);

% Initialise weights
kohonenWeights = -1 + 2*rand(nKohonenNodes,2);

% trick for speed
tmp = 1:nKohonenNodes;
A = repmat(tmp,nKohonenNodes,1)-repmat(tmp',1,nKohonenNodes);
A = triu(A) + triu(A)';
neighbourhoodMatrix = exp(-(A.^2)/(2*sigmaNeighbourhoodFunction^2));

% ===============================================================
%% Plot weights update on-the-go (cool, but not recommended for nRuns > 1)
% figure();
% hold on
% dataPlot = plot(patterns(:,1),patterns(:,2),'.','MarkerSize',12);
% weightsPlot = plot(kohonenWeights(:,1),kohonenWeights(:,2),'x');
% set(weightsPlot,'LineWidth',2,'MarkerSize',20);   
% hold off
% ===============================================================

%% Training loop
for iKohonen = 1:nIterationsKohonen
    
  iPattern = randi(nPatterns); 
  inputPattern = patterns(iPattern,:);
  
  iWinning = GetWinningNeuron(inputPattern, kohonenWeights);
  kohonenWeights = UpdateWeights(kohonenWeights, iWinning, inputPattern,...
  etaKohonen, neighbourhoodMatrix);

% ===============================================================    
%   if mod(iKohonen,1000) == 0
%     set(weightsPlot,'XData',kohonenWeights(:,1));
%     set(weightsPlot,'YData',kohonenWeights(:,2));
%     drawnow;
%   end
% ===============================================================
end

end
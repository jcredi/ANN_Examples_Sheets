function resultsStructure = Backpropagation(patterns, patternClasses, kohonenWeights, ...
    nIterationsBackpropagation, beta, etaBackpropagation, nIterationsBetweenPlots)
%% Backpropagation

nPatterns = size(patterns, 1);
nKohonenNodes = size(kohonenWeights,1);
nPlotPoints = 1+fix(nIterationsBackpropagation/nIterationsBetweenPlots);

% Randomly split data in training and validation sets
nTrainingData = fix(0.7*nPatterns);
trainingData = randperm(nPatterns, nTrainingData);
validationData = setdiff(1:nPatterns, trainingData);

% Initalisations
perceptronWeights = -1 + 2*rand(1,nKohonenNodes+1);
energyTraining = zeros(1, nPlotPoints);
errorTraining = zeros(1, nPlotPoints);
energyValidation = zeros(1, nPlotPoints);
errorValidation = zeros(1, nPlotPoints);
iPlot = 1;

% Compute initial energy and error
[energyTraining(iPlot), errorTraining(iPlot)] = ComputeEnergyAndError(...
patterns, patternClasses, kohonenWeights, perceptronWeights, beta);
[energyValidation(iPlot), errorValidation(iPlot)] = ComputeEnergyAndError(...
patterns, patternClasses, kohonenWeights, perceptronWeights, beta);

%======================================
%% Draw colormap on-the-go (cool, but not recommended for nRuns > 1)
%
% rangeX = [-15, 25];
% rangeY = [-10, 15];
% spacing = 0.33;
% [randomDataX,randomDataY] = meshgrid(rangeX(1):spacing:rangeX(2), rangeY(1):spacing:rangeY(2));
% nY = size(randomDataX,1);
% nX = size(randomDataX,2);
% randomDataZ = zeros(size(randomDataX));
% % Pass through classifier
% for iY = 1:nY
%   for iX = 1:nX
%     inputPattern = [randomDataX(iY,iX), randomDataY(iY,iX)];
%     [~, randomDataZ(iY,iX)] = RunClassifier(inputPattern, ...
%       kohonenWeights, nKohonenNodes, perceptronWeights, beta);
%   end
% end
% % Pseudocolor map
% pcolor(randomDataX,randomDataY,randomDataZ)
% shading flat
% axis square;
%======================================

for iBackpropagation = 1:nIterationsBackpropagation

  % pick pattern from training set
  iPattern = trainingData(randi(nTrainingData));
  inputPattern = patterns(iPattern,:);
  desiredOutput = patternClasses(iPattern);
  
  % run classifier
  [gaussianActivation, output] = RunClassifier(inputPattern, ...
    kohonenWeights, nKohonenNodes, perceptronWeights, beta);

  % backpropagation
  gPrime = beta*(1-output.^2); % because we're using g = tanh
  outputError = desiredOutput - output;
  deltaWeights = etaBackpropagation*outputError*gPrime*gaussianActivation';
  perceptronWeights = perceptronWeights + deltaWeights;
  
  % compute energy and classification error
  if mod(iBackpropagation,nIterationsBetweenPlots) == 0
    iPlot = iPlot + 1;
    [energyTraining(iPlot), errorTraining(iPlot)] = ComputeEnergyAndError(...
      patterns(trainingData,:), patternClasses(trainingData), ...
      kohonenWeights, perceptronWeights, beta);
    [energyValidation(iPlot), errorValidation(iPlot)] = ComputeEnergyAndError(...
      patterns(validationData,:), patternClasses(validationData), ...
      kohonenWeights, perceptronWeights, beta);
    
    %======================================
%     % Pass random data through classifier
%     for iY = 1:nY
%       for iX = 1:nX
%         inputPattern = [randomDataX(iY,iX), randomDataY(iY,iX)];
%         [~, randomDataZ(iY,iX)] = RunClassifier(inputPattern, ...
%           kohonenWeights, nKohonenNodes, perceptronWeights, beta);
%       end
%     end
%     % Pseudocolor map
%     pcolor(randomDataX,randomDataY,randomDataZ);
%     shading flat;
%     axis square;
%     pause(0.001);
    %======================================
  end
end

% Save results in a structure
resultsStructure.kohonenWeights = kohonenWeights;
resultsStructure.perceptronWeights = perceptronWeights;
resultsStructure.energyTraining = energyTraining;
resultsStructure.energyValidation = energyValidation;
resultsStructure.errorTraining = errorTraining;
resultsStructure.errorValidation = errorValidation;

end
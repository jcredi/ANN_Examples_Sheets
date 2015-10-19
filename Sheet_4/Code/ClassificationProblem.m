%% CLASSIFICATIONPROBLEM Main script for ANN - Examples sheet 4
clear; clc; close all;

%% Parameters
nRuns = 20;
nCurvesToPlot = 3;

nIterationsKohonen = 1e5;
nKohonenNodes = 5;
etaKohonen = 0.02;
sigmaNeighbourhoodFunction = 0.1;

nIterationsBackpropagation = 1e4;
nOutputNodes = 1;
etaBackpropagation = 0.1;
beta = 0.5;
nIterationsBetweenPlots = 100;

%% Load data
tmpData = importdata('../Data/data_classify.txt');
patternClasses = tmpData(:,1);
patterns = tmpData(:,2:end);
nPatterns = size(patterns, 1);

%% Loop over runs
for iRun = 1:nRuns
  
  fprintf('\nRUN %i:\n',iRun);
    
  % Unsupervised learning part (Kohonen)
  tic;
  kohonenWeights = CompetitiveLearning(patterns, nKohonenNodes, ...
    sigmaNeighbourhoodFunction, nIterationsKohonen, etaKohonen);
  fprintf('  - Competitive learning completed in %4.3f seconds.\n',toc);

  % Supervised learning part (backpropagation)
  tic;
  resultsStructure(iRun) = Backpropagation(patterns,patternClasses,kohonenWeights,...
    nIterationsBackpropagation, beta, etaBackpropagation, nIterationsBetweenPlots);
  fprintf('  - Perceptron backpropagation completed in %4.3f seconds.\n',toc);  
  
end
clc;
fprintf('%i runs with %i Kohonen nodes completed.\n',nRuns,nKohonenNodes);

% Plot energy and error (3 curves)
whichOnes = randperm(nRuns,nCurvesToPlot);
[energyTrainingPlot, energyValidationPlot] = PlotEnergy(whichOnes, ...
  nIterationsBetweenPlots, nIterationsBackpropagation, resultsStructure);
[errorTrainingPlot, errorValidationPlot] = PlotError(whichOnes,...
  nIterationsBetweenPlots, nIterationsBackpropagation, resultsStructure);

% Average energy and error (with uncertainties) for training and validation
tmpEnTr = zeros(nRuns,1);
tmpEnVal = zeros(nRuns,1);
tmpErrTr = zeros(nRuns,1);
tmpErrVal = zeros(nRuns,1);
for iRun = 1:nRuns
  tmpEnTr(iRun) = resultsStructure(iRun).energyTraining(end);
  tmpEnVal(iRun) = resultsStructure(iRun).energyValidation(end);
  tmpErrTr(iRun) = resultsStructure(iRun).errorTraining(end);
  tmpErrVal(iRun) = resultsStructure(iRun).errorValidation(end);
end
avgEnergyTraining = mean(tmpEnTr);
errEnergyTraining = std(tmpEnTr);
avgEnergyValidation = mean(tmpEnVal);
errEnergyValidation = std(tmpEnVal);
avgErrorTraining = mean(tmpErrTr);
errErrorTraining = std(tmpErrTr);
avgErrorValidation = mean(tmpErrVal);
errErrorValidation = std(tmpErrVal);
[~,iBestClassifier] = min(tmpErrVal);

fprintf('\n  Final energy (training set): %4.3f, uncertainty: %4.3f',avgEnergyTraining,errEnergyTraining);
fprintf('\n  Final energy (validation set): %4.3f, uncertainty: %4.3f',avgEnergyValidation,errEnergyValidation);

fprintf('\n\n  Final classification error (training set): %4.3f, uncertainty: %4.3f',avgErrorTraining,errErrorTraining);
fprintf('\n  Final classification error (validation set): %4.3f, uncertainty: %4.3f\n\n',avgErrorValidation,errErrorValidation);

disp('Run script "DecisionBoundary.m" for a graphical representation of the decision boundary for the best network found.');







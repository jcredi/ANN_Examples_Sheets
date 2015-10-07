%MultilayerPerceptronBackpropagation
clear
close all
tic

% ======================================================================= %
% PARAMETERS
% ======================================================================= %
% can specify a perceptron of L+1 layers (any L), but use 1 output neuron 
% for safety (not tested with multiple outputs, though it should work)
networkArchitecture = [2 3 2 1]; 
beta = 0.5;
learningRate = 0.01;
weightRange = 0.2;
biasRange = 1.0;
nIterations = 1e6;
iterationsBetweenPlots = 1000;
nRuns = 10;
trainingDataPath = '../Data/train_data_new.txt';
validationDataPath = '../Data/valid_data_new.txt';
% ======================================================================= %


% Read and normalize training and validation data sets
[trainingPatterns, trainingOutputs] = ReadData(trainingDataPath);
[validationPatterns, validationOutputs] = ReadData(validationDataPath);
nTraining = size(trainingPatterns,1);
nValidation = size(validationPatterns,1);
[trainingPatterns, validationPatterns] = NormalizeData(trainingPatterns,...
    validationPatterns);

% Add dummy neuron with fixed value -1 (for including biases in weights)
trainingPatterns = [trainingPatterns, -ones(nTraining,1)];
validationPatterns = [validationPatterns, -ones(nValidation,1)];

% Initialise output data structure
x = 0:iterationsBetweenPlots:nIterations;
nPlotPoints = length(x);
emptyData = nan(1,length(x));
outputData = repmat(struct('errorTraining',emptyData,'errorValidation',...
    emptyData,'energyTraining',emptyData,'energyValidation',emptyData), ...
    nRuns, 1 );

%% Loop over runs
parfor run = 1:nRuns

  % Initialize random weight matrix (or, well, cell of matrices)
  weightsCell = InitialiseWeightsBiases(networkArchitecture, weightRange, biasRange);

  % Initialize plots (only use if nRuns = 1)
%     [errorHandle, trainingErrorHandle, validationErrorHandle, ...
%       energyHandle, trainingEnergyHandle, validationEnergyHandle] = ...
%       InitialisePlots(x, nPlotPoints);

  tPlot = 1;

  % Compute initial classification error and energy for training set
  [trainingError, trainingEnergy] = ComputeErrorAndEnergy(weightsCell,...
   beta, trainingPatterns, trainingOutputs);
    
  % Compute initial classification error and energy for validation set
  [validationError, validationEnergy] = ComputeErrorAndEnergy(...
    weightsCell, beta, validationPatterns, validationOutputs);
      
  % Store values
  outputData(run).errorTraining(tPlot) = trainingError;
  outputData(run).energyTraining(tPlot) = trainingEnergy;
  outputData(run).errorValidation(tPlot) = validationError;
  outputData(run).energyValidation(tPlot) = validationEnergy;
  
  for t = 1:nIterations
    
    % Pick pattern to feed (and corresponding output)
    patternID = randi(nTraining);
    inputPattern = trainingPatterns(patternID,:)';
    desiredOutput = trainingOutputs(patternID,:)';
  
    % Run perceptron
    perceptronState = RunPerceptron(inputPattern, weightsCell, beta);
  
    % Backpropagation
    weightsCell = Backpropagation(perceptronState, weightsCell, ...
      desiredOutput, beta, learningRate);

    if mod(t,iterationsBetweenPlots) == 0
      tPlot = tPlot+1;

      % Compute and store classification error and energy for training set
      [trainingError, trainingEnergy] = ComputeErrorAndEnergy(...
          weightsCell, beta, trainingPatterns, trainingOutputs);
    
      % Compute and store classification error and energy for validation set
      [validationError, validationEnergy] = ComputeErrorAndEnergy(...
          weightsCell, beta, validationPatterns, validationOutputs);
      
      % Store values
      outputData(run).errorTraining(tPlot) = trainingError;
      outputData(run).energyTraining(tPlot) = trainingEnergy;
      outputData(run).errorValidation(tPlot) = validationError;
      outputData(run).energyValidation(tPlot) = validationEnergy;
      
      % Update plots (only use if nRuns = 1)
%       UpdatePlots(tPlot, trainingErrorHandle, trainingError, ...
%         validationErrorHandle, validationError, trainingEnergyHandle, ...
%         trainingEnergy, validationEnergyHandle, validationEnergy);


%       if trainingError == 0 && validationError == 0
% %         load handel
% %         sound(y,Fs)
%         fprintf('\nRUN %i: zero classification error reached. Training stopped after %i iterations.\n.', ...
%           run, t);
%         break
%       end
      
    end
    
  end
  
end
[errorHandle, energyHandle] = PlotErrorEnergy(outputData,x);

toc




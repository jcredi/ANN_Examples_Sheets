%MAIN
clear
tic

% ======================================================================= %
% PARAMETERS
% ======================================================================= %
neuronsInLayers = [2 1]; % can specify more than 2 layers
beta = 0.5;
learningRate = 0.01;
weightRange = 0.2;
biasRange = 1.0;
nIterations = 1e5;
trainingRuns = 10;
% ======================================================================= %

trainingDataPath = '../Data/train_data1.txt';
validationDataPath = '../Data/valid_data1.txt';

% Read training and validation data sets
[trainingPatterns, trainingOutputs] = ReadData(trainingDataPath);
[validationPatterns, validationOutputs] = ReadData(validationDataPath);
nTraining = size(trainingPatterns,1);
nValidation = size(validationPatterns,1);

% Normalize data
[trainingPatterns, validationPatterns] = ...
    NormalizeData(trainingPatterns, validationPatterns);

% Add dummy neuron with fixed value -1 (for including bias in weights)
trainingPatterns = [trainingPatterns, -ones(nTraining,1)];
validationPatterns = [validationPatterns, -ones(nValidation,1)];

% Initialize weight matrix (or, well, cell of matrices)
weightsCell = InitializeWeights(neuronsInLayers, weightRange, biasRange);

% Main loop
h = waitbar(0,'Please wait...');
for t = 1:nIterations
    patternID = randi(nTraining);
    inputPattern = trainingPatterns(patternID,:)';
    desiredOutput = trainingOutputs(patternID,:)';
    
    perceptronState = RunPerceptron(inputPattern, weightsCell, beta);
    weightsCell = Backpropagation(perceptronState, weightsCell, ...
        desiredOutput, beta, learningRate);
    
    waitbar(t/nIterations,h);
end
close(h);
toc




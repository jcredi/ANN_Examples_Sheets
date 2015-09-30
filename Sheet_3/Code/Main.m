%MAIN
clear

neuronsInLayers = [2 1]; % can specify more than 2 layers
beta = 0.5;
weightRange = 0.2;
biasRange = 1.0;

trainingDataPath = '../Data/train_data1.txt';
validationDataPath = '../Data/valid_data1.txt';

% Read training and validation data sets
[trainingPatterns, trainingOutputs] = ReadData(trainingDataPath);
[validationPatterns, validationOutputs] = ReadData(validationDataPath);

% Normalize data
[trainingPatterns, validationPatterns] = ...
    NormalizeData(trainingPatterns, validationPatterns);

% Compute some useful values
nTraining = size(trainingPatterns,1);
nValidation = size(validationPatterns,1);

% Add dummy neuron with fixed value -1
trainingPatterns = [trainingPatterns, -ones(nTraining,1)];
validationPatterns = [validationPatterns, -ones(nValidation,1)];

% Initialize weight matrix
weightsCell = InitializeWeights(neuronsInLayers, weightRange, biasRange);

inputPattern = trainingPatterns(1,:)';
% Run perceptron
perceptronState = RunPerceptron(inputPattern, weightsCell, beta);
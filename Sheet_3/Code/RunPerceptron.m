function perceptronState = RunPerceptron(inputPattern, weightsCell, beta)
%RUNPERCEPTRON

L = size(weightsCell,2);
perceptronState = cell(2,L+1);
% first "row": neuron states
% second "row": b values

perceptronState{1,1} = inputPattern;
perceptronState{2,1} = []; % b values don't exist for 1st layer

for l = 1:L
    W = weightsCell{1,l};
    b = beta*W*perceptronState{1,l};
    perceptronState{2,l+1} = b; % storing b values for backpropagation
    perceptronState{1,l+1} = [tanh(b); -1]; % dummy -1 added
end

% remove dummy neuron from output layer
perceptronState{1,L+1}(end) = [];

end
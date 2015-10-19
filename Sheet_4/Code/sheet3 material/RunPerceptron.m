function perceptronState = RunPerceptron(inputPattern, weightsCell, beta)
%RUNPERCEPTRON

L = size(weightsCell,2); % L+1 layers
perceptronState = cell(1,L+1);

perceptronState{1,1} = inputPattern;

for l = 1:L
    b = beta*weightsCell{1,l}*perceptronState{1,l};
    perceptronState{1,l+1} = [tanh(b); -1]; % dummy -1 added
end

% remove dummy neuron from output layer
perceptronState{1,L+1}(end) = [];

end
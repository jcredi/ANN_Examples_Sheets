function perceptronState = RunPerceptron(inputPattern, weightsCell, beta)
%RUNPERCEPTRON

L = size(weightsCell,2);
perceptronState = cell(1,L+1);

perceptronState{1,1} = inputPattern;

for l = 1:L
    W = weightsCell{1,l};
    perceptronState{1,l+1} = tanh(beta*W*perceptronState{1,l});
end

end
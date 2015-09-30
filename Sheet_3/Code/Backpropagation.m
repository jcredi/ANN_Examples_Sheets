function updatedWeightsCell = Backpropagation(perceptronState, ...
    weightsCell, desiredOutput, beta, learningRate)
%BACKPROPAGATION

L = length(weightsCell);
updatedWeightsCell = weightsCell;

% Update last part of the network
gPrime = beta*(1-(tanh(perceptronState{2,end})).^2);
delta = (desiredOutput - perceptronState{1,end}).*gPrime;
dW = learningRate*(delta*perceptronState{1,end-1}'); % note the transpose!
updatedWeightsCell{1,end} = weightsCell{1,end} + dW;
% this should be able to handle multidimensional output

% And now backpropagate to the rest of the network (if any)
if L > 1
    for l = L-1:1
        gPrime = beta*(1-(tanh(perceptronState{2,l+1})).^2);
        % this is a trick to make computation easier to write and run
        tempW = weightsCell{1,l+1}';
        tempW(end,:) = [];
        delta = (tempW*delta).*gPrime;
        dw = learningRate*(delta*perceptronState{1,l}'); % also note transpose
        updatedWeightsCell{1,l} = weightsCell{1,l} + dw;
    end
end

end
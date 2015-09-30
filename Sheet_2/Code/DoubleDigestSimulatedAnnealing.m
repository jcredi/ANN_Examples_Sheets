function solution = DoubleDigestSimulatedAnnealing(seqA, seqB, trueC, maxTime, alpha)
%DOUBLEDIGESTSIMULATEDANNEALING
%   solution = DoubleDigestSimulatedAnnealing(seqA, seqB, trueC, maxTime, alpha)
%
%	This function performs a simulated annealing search of an optimal
%	sequence solving the double digest problem. 
%
%	INPUTS: 
%   - sequence a (digested by A)
%   - sequence b (digested by B)
%   - sequence c (digested by both A and B)
%   - max allowed number of iterations
%   - increase rate for beta (it's also starting value for beta at t=1)
%
%   OUTPUT variable is a structure with the following fields:
%   - solution.a : best a-sequence found
%   - solution.b : best b-sequence found
%   - solution.c : best c-sequence found
%   - solution.energy : evolution of energy over time
%   - solution.isOptimal : logical value, true if the found sequence is optimal
%   - solution.runTime : number of iterations needed to find optimal (this
%   value is NaN if optimal solution was not found)


%% Preliminary operations and initializations
nA = numel(seqA);
nB = numel(seqB);
energy = zeros(1,maxTime);
beta = alpha;
time = 1;
isOptimal = false;
runTime = nan;

% Initial guesses (random permutations)
guessA = seqA(randperm(nA));
guessB = seqB(randperm(nB));

% Initialize random logical 1d array (which to update between sigma and mu)
whichToUpdate = rand(maxTime+1,1) > 0.5;

% Corresponding c and initial energy
cTilde = DigestAB(guessA, guessB);
energy(time) = ComputeEnergy( trueC, cTilde);

%% Main loop
while time < maxTime
    
    time = time + 1;
    
    % Make new guesses for sequences a and b and corresponding sequence c
    if whichToUpdate(time) % update sigma
        newGuessA = SampleNeighbourPermutation(guessA);
        newGuessB = guessB;
    else % update mu        
        newGuessA = guessA;     
        newGuessB = SampleNeighbourPermutation(guessB);
    end
    cTilde = DigestAB(newGuessA, newGuessB);

    % Compute newEnergy and decide whether to accept new permutations
    newEnergy = ComputeEnergy( trueC, cTilde);
    
    if AcceptUpdate( beta, newEnergy, energy(time-1));
        guessA = newGuessA;
        guessB = newGuessB;
        energy(time) = newEnergy;
    else
        energy(time) = energy(time-1);
    end
    
    % Check whether an optimal configuration was found
    if newEnergy == 0
        isOptimal = true;
        runTime = time;
        energy(time+1:end) = [];
        break
    end
    
    % Update beta
    beta = alpha*time;
end

solution.a = guessA;
solution.b = guessB;
solution.c = cTilde;
solution.energy = energy;
solution.isOptimal = isOptimal;
solution.runTime = runTime;

end
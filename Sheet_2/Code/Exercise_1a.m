%EXERCISE_1A
clear
tic

% ======================================================================= %
% Parameters
% ======================================================================= %

% From data_2.rtf
a = [8479, 4868, 3696, 2646, 169, 142];
b = [11968, 5026, 1081, 1050, 691, 184];
c = [8479, 4167, 2646, 1081, 881, 859, 701, 691, 184, 169, 142];

nRuns = 100;
maxTime = 10000; feature('numcores') % 50000 is enough for data1
alpha = 1e-6; % 5e-6 is enough for data1

% ======================================================================= %

% Initialize output cell array
solutions = repmat(struct('a',a,'b',b,'c',c,'energy',1:maxTime,...
    'isOptimal',false,'runTime',nan), nRuns, 1 );
tic
%% Main (parallel) loop
p =  TimedProgressBar( nRuns, 30, ...
    'Computing... Estimated time left: ', '   Completed: ', 'Completed in ' );
parfor run = 1:nRuns
    solutions(run) = DoubleDigestSimulatedAnnealing( a, b, c, maxTime, alpha);
    p.progress;
end
p.stop;
[ differentSolutions, nSolutions] = CountSolutions( solutions );


fprintf('Fraction of optimal solutions: %f\n', ...
    mean(cell2mat(extractfield(solutions,'isOptimal'))));
fprintf('Average number of iterates for convergence to optimal: %i\n', ...
    int32(nanmean(extractfield(solutions,'runTime'))));
fprintf('Number of different optimal solutions found: %i\n', nSolutions);
%semilogy(energy,'LineWidth',2)

[f1, f2, f3, which] = PlotEnergy(solutions);

delete('timedProgressbar_Transient(deleteThis)_*.txt');
toc
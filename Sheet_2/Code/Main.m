%MAIN
clear

% ======================================================================= %
% Parameters
% ======================================================================= %

% Use either data from data_1.rtf or data_2.rtf
a=[9979, 9348, 8022, 4020, 2693, 1892, 1714, 1371, 510, 451];
b=[9492, 8453, 7749, 7365, 2292, 2180, 1023, 959, 278, 124, 85];
c=[7042, 5608, 5464, 4371, 3884, 3121, 1901, 1768, 1590, 959, 899, 707, 702, 510, 451, 412, 278, 124, 124, 85];

nRuns = 50;
maxTime = 750000; % use 50000 for data1, 500000 for data2
alpha = 1e-7; % 1e-6 for data1, 1e-7 for data2

% ======================================================================= %

% Initialize output cell array
solutions = repmat(struct('a',a,'b',b,'c',c,'energy',1:maxTime,...
    'isOptimal',false,'runTime',nan), nRuns, 1 );

%% Main (parallel) loop
p =  TimedProgressBar( nRuns, 30, ...
    'Computing... Estimated time left: ', '   Completed: ', 'Completed in ' );
parfor run = 1:nRuns
    solutions(run) = DoubleDigestSimulatedAnnealing( a, b, c, maxTime, alpha);
    p.progress;
end
p.stop;
[ differentSolutions, nSolutions] = CountSolutions( solutions );

% Print some output to console
fprintf('\nFraction of optimal solutions: %f\n', ...
    mean(cell2mat(extractfield(solutions,'isOptimal'))));
fprintf('Average number of iterates for convergence to optimal: %i\n', ...
    int32(nanmean(extractfield(solutions,'runTime'))));
fprintf('Number of different optimal solutions found: %i\n', nSolutions);


%[f1, f2, f3, which] = PlotEnergy(solutions);

delete('timedProgressbar_Transient(deleteThis)_*.txt');
function [errorHandle, trainingErrorHandle, validationErrorHandle, ...
    energyHandle, trainingEnergyHandle, validationEnergyHandle] = ...
    InitialisePlots(x, nPlotPoints)
%INITIALISEPLOTS

errorHandle = figure;
set(gcf,'color','w');
hold on;
set(errorHandle, 'Position', [100,100,800,400]);
set(errorHandle, 'DoubleBuffer','on');
xlim([0 x(end)]);
xlabel('Training iterations');
ylabel('Classification Error C_V');
set(gca, 'FontSize', 16);
trainingErrorHandle = plot(x, nan(1,nPlotPoints), ...
    'LineWidth',1.5);
validationErrorHandle = plot(x, nan(1,nPlotPoints), ...
    'LineWidth',1.5);
legend([trainingErrorHandle, validationErrorHandle], 'Training set', ...
    'Validation set');
hold off;
drawnow;


energyHandle = figure;
set(gcf,'color','w');
hold on;
set(energyHandle, 'Position', [1000,100,800,400]);
set(energyHandle, 'DoubleBuffer','on');
xlim([0 x(end)]);
xlabel('Training iterations');
ylabel('Energy H');
set(gca, 'FontSize', 16);
trainingEnergyHandle = plot(x, nan(1,nPlotPoints), 'LineWidth',1.5);
validationEnergyHandle = plot(x, nan(1,nPlotPoints), 'LineWidth',1.5);
legend([trainingEnergyHandle, validationEnergyHandle], 'Training set', ...
    'Validation set');
hold off;
drawnow;




end
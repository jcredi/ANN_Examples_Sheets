function [errorHandle, energyHandle] = PlotErrorEnergy(outputData,x,which)
%PlotErrorEnergy

if ~exist('which','var')
  which = 1:length(outputData);
end
parulaColours = get(groot,'DefaultAxesColorOrder');
defaultBlue = parulaColours(1,:);
defaultRed = parulaColours(2,:);

%% Classification error figure
errorHandle = figure;
hold on;
set(errorHandle,'color','w','Position', [100,250,800,500]);
xlabel('Training iterations');
ylabel('Classification Error C_V');
set(gca, 'FontSize', 16);
legend1 = plot(nan,nan,'LineWidth',2);
legend2 = plot(nan,nan,'LineWidth',2);
legend([legend1, legend2], 'Training set', 'Validation set');

for ii = which
  plot(x,outputData(ii).errorTraining,'Color',defaultBlue,'LineWidth',1.5);
  plot(x,outputData(ii).errorValidation,'Color',defaultRed,'LineWidth',1.5);
end
hold off;

%% Energy figure
energyHandle = figure;
hold on;
set(energyHandle,'color','w','Position', [1000,250,800,500]);
xlabel('Training iterations');
ylabel('Energy H');
set(gca, 'FontSize', 16);
legend1 = plot(nan,nan,'LineWidth',2);
legend2 = plot(nan,nan,'LineWidth',2);
legend([legend1, legend2], 'Training set', 'Validation set');

for ii = which
  plot(x,outputData(ii).energyTraining,'Color',defaultBlue,'LineWidth',1.5);
  plot(x,outputData(ii).energyValidation,'Color',defaultRed,'LineWidth',1.5);
end
hold off;

end
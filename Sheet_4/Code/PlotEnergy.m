function [energyTrainingPlot, energyValidationPlot] = PlotEnergy(whichOnes,...
  nIterationsBetweenPlots, nIterationsBackpropagation, resultsStructure)
%% PlotEnergy

xValues = 1:nIterationsBetweenPlots:(nIterationsBackpropagation+1);
nCurvesToPlot = numel(whichOnes);

parulaColours = get(groot,'DefaultAxesColorOrder');
defaultBlue = parulaColours(1,:);
defaultRed = parulaColours(2,:);

figure('Units','normalized','OuterPosition',[0.15 0.15 0.7 0.7]);
set(gcf, 'Color','w');
hold on

for i = 1:nCurvesToPlot
    
  iPlot = whichOnes(i);
  
  % training
  energyTrainingPlot(iPlot) = semilogy(xValues,resultsStructure(iPlot).energyTraining);
  set(energyTrainingPlot(iPlot),'Color',defaultBlue,'LineWidth',1.5);
  
  % validation
  energyValidationPlot(iPlot) = semilogy(xValues,resultsStructure(iPlot).energyValidation);
  set(energyValidationPlot(iPlot),'Color',defaultRed,'LineWidth',1.5);
  
end

set(gca,'yscale','log','FontSize',16);
xlabel('Backpropagation itereations');
ylabel('Energy H');
xlim([0,nIterationsBackpropagation]);
set(0, 'DefaultAxesBox', 'on');
legend([energyTrainingPlot(iPlot), energyValidationPlot(iPlot)],'Training data','Validation data');
pbaspect([1.618 1 1])
hold off

end
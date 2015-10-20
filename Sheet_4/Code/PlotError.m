function [errorTrainingPlot, errorValidationPlot] = PlotError(whichOnes,...
  nIterationsBetweenPlots, nIterationsBackpropagation, resultsStructure)
%% PlotError

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
  errorTrainingPlot(iPlot) = plot(xValues,resultsStructure(iPlot).errorTraining);
  set(errorTrainingPlot(iPlot),'Color',defaultBlue,'LineWidth',1.5);
  
  % validation
  errorValidationPlot(iPlot) = plot(xValues,resultsStructure(iPlot).errorValidation);
  set(errorValidationPlot(iPlot),'Color',defaultRed,'LineWidth',1.5);
  
end

set(gca,'FontSize',16);
xlabel('Backpropagation itereations');
ylabel('Classification error');
xlim([0,nIterationsBackpropagation]);
set(0, 'DefaultAxesBox', 'on');
legend([errorTrainingPlot(iPlot), errorValidationPlot(iPlot)],'Training data','Validation data');
pbaspect([1.618 1 1])
hold off

end
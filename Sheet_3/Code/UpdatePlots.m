function [] = UpdatePlots(tPlot, trainingErrorHandle, trainingError, ...
    validationErrorHandle, validationError, trainingEnergyHandle, ...
    trainingEnergy, validationEnergyHandle, validationEnergy)
%UPDATEPLOTS

plotTrainingError = get(trainingErrorHandle,'YData');
plotTrainingError(tPlot) = trainingError;
set(trainingErrorHandle,'YData', plotTrainingError);

plotValidationError = get(validationErrorHandle,'YData');
plotValidationError(tPlot) = validationError;
set(validationErrorHandle,'YData', plotValidationError);

plotTrainingEnergy = get(trainingEnergyHandle,'YData');
plotTrainingEnergy(tPlot) = trainingEnergy;
set(trainingEnergyHandle,'YData', plotTrainingEnergy);

plotValidationEnergy = get(validationEnergyHandle,'YData');
plotValidationEnergy(tPlot) = validationEnergy;
set(validationEnergyHandle,'YData', plotValidationEnergy);

drawnow;

end
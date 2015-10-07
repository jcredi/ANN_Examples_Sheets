function [] = PlotTrainingData(trainingPatterns, trainingOutputs)

tmp = trainingOutputs > 0;

plusOnePatterns = trainingPatterns(tmp,:);
minusOnePatterns = trainingPatterns(~tmp,:);

plot(plusOnePatterns(:,1),plusOnePatterns(:,2),'.','MarkerSize',25);
hold on
plot(minusOnePatterns(:,1),minusOnePatterns(:,2),'.','MarkerSize',25);
hold off

end
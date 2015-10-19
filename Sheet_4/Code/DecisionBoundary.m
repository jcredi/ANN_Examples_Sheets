%% DECISIONBOUNDARY Script to draw decision boundary and colormap

nRandomData = 1e5;
rangeX = [-15, 25];
rangeY = [-10, 15];
spacing = 0.33;
beta = 0.5;
threshold = 0.01;

bestKohonenWeights = resultsStructure(iBestClassifier).kohonenWeigths;
bestPerceptronWeights = resultsStructure(iBestClassifier).perceptronWeights;

%% Initialise plot
figure('Units','normalized','OuterPosition',[0.15 0.15 0.7 0.7]);
set(gcf, 'Color','w');
hold on
parulaColours = get(groot,'DefaultAxesColorOrder');
colour1 = parulaColours(1,:);
colour2 = parulaColours(3,:);

%% Generate random data (for decision boundary)
randomDataX = rangeX(1) + diff(rangeX)*rand(nRandomData,1);
randomDataY = rangeY(1) + diff(rangeY)*rand(nRandomData,1);
randomDataZ = zeros(nRandomData,1);
% Pass through classifier
for iRandomData = 1:nRandomData
    inputPattern = [randomDataX(iRandomData), randomDataY(iRandomData)];
    [~, randomDataZ(iRandomData)] = RunClassifier(inputPattern, bestKohonenWeights, ...
      nKohonenNodes, bestPerceptronWeights, beta);
end
% Generate decision boundary
decisionBoundaryX = randomDataX(abs(randomDataZ) < threshold);
decisionBoundaryY = randomDataY(abs(randomDataZ) < threshold);
[decisionBoundaryX, order] = sort(decisionBoundaryX);
decisionBoundaryY = decisionBoundaryY(order);

% Subplot 1
subplot(1,2,1);
plotCluster1 = plot(patterns(1:1000,1),patterns(1:1000,2));
set(plotCluster1,'LineStyle','none','Marker','s','MarkerSize',6,'LineWidth',1,'Color',colour2);
hold on

plotCluster2 = plot(patterns(1001:end,1),patterns(1001:end,2),'o','MarkerSize',10);
set(plotCluster2,'LineStyle','none','Marker','o','MarkerSize',6,'LineWidth',1,'Color',colour1);

plotWeights = plot(bestKohonenWeights(:,1),bestKohonenWeights(:,2),'x');
set(plotWeights,'LineWidth',2,'MarkerSize',16,'Color','r');   

plotDecisionBoundary = plot(decisionBoundaryX, decisionBoundaryY,'r','LineWidth',2);
set(gca,'FontSize',16);
axis square;
xlim([-15, 25]);
hold off

%% Generate meshgrid (for pseudo-colour map)
[meshGridX,meshGridY] = meshgrid(rangeX(1):spacing:rangeX(2), rangeY(1):spacing:rangeY(2));
nY = size(meshGridX,1);
nX = size(meshGridX,2);
meshGridZ = zeros(size(meshGridX));
% Pass through classifier
for iY = 1:nY
  for iX = 1:nX
    inputPattern = [meshGridX(iY,iX), meshGridY(iY,iX)];
    [~, meshGridZ(iY,iX)] = RunClassifier(inputPattern, ...
      bestKohonenWeights, nKohonenNodes, bestPerceptronWeights, beta);
  end
end

% Plot pseudo-colour map
subplot(1,2,2);
pcolor(meshGridX,meshGridY,meshGridZ)
shading interp
axis square;
set(gca,'FontSize',16);

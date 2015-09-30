function [ histHandle, curveHandle ] = LogPlotCTT( crossTalkTerms , alpha)
%LOGPLOTCTT
%   Remember that alpha = p/N

figure('units','normalized','outerposition',[0 0 1 1])

% create and plothistogram
%[binnedVals] = histcounts(crossTalkTerms(:));
%nBins = round(length(binnedVals)/23);
[estimatedProb,edges] = histcounts(crossTalkTerms(:),16,'Normalization','pdf');
binCenters = edges(1:end-1)+0.5*(edges(2)-edges(1));
histHandle = bar(binCenters,-log(estimatedProb));
hold on

% create normal curve points and plot them
xVals = linspace( min(-2,min(crossTalkTerms(:))), max(2,max(crossTalkTerms(:))), 100);
yVals = normpdf(xVals, 0, sqrt(alpha));
curveHandle = plot(xVals,-log(yVals),'r','LineWidth',2);
hold off

% plot settings
set(histHandle,'FaceColor', [0 0.4470 0.7410]);
set(gcf,'color','w');
xlabel('C_k^{(\nu)}');
ylabel('-log P(C_k^{(\nu)})');
axis square;
set(gca,'fontsize', 30);

end


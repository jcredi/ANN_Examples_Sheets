function [ histHandle, curveHandle ] = PrettyPlotCTT( crossTalkTerms , alpha)
%PRETTYPLOTCTT
%   Remember that alpha = p/N

figure('units','normalized','outerposition',[0 0 1 1])

% plot histogram
histHandle = histogram(crossTalkTerms(:),16,'Normalization','pdf');
%histHandle.NumBins = round(histHandle.NumBins/20);

% create linspaced x values for normal curve
xVals = linspace( min(-2,min(crossTalkTerms(:))), max(2,max(crossTalkTerms(:))), 100);
yVals = normpdf(xVals, 0, sqrt(alpha));

% plot curve
hold on
curveHandle = plot(xVals,yVals,'r','LineWidth',2);
hold off

% additional settings
set(gcf,'color','w');
xlabel('C_k^{(\nu)}');
ylabel('-log P(C_k^{(\nu)})');
axis square;
set(gca,'fontsize', 30);

end


% Plot stuff to check

whatToPlot = dataset;

for ii = 1:8
    for jj = 1:6
        plot(squeeze(whatToPlot(ii,jj,:)));
        disp([ii jj]);
        pause
    end
end
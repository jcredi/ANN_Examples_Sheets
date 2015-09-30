%STATANALYSIS
% quick statistical analysis

burnIn = 1000;
dataset = orderParamDataset;

% smoothing
for ii = 1:8
    for jj = 1:6
        dataset(ii,jj,:) = smooth(squeeze(dataset(ii,jj,:)),100);
    end
end

% remove initial values
dataset = dataset(:,:,burnIn+1:end);

meanValues = (mean(dataset,3));
lowerQuantiles = (quantile(dataset,0.05,3));
upperQuantiles = (quantile(dataset,0.95,3));

errors = max(upperQuantiles-meanValues,meanValues-lowerQuantiles);

%imagesc(meanValues);
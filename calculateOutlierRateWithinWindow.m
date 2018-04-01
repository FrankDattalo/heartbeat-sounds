function percentOutliers = calculateOutlierRateWithinWindow(data, window)
%CALCULATEOUTLIERRATEWITHINWINDOW uses moving medians to calculate the
% percentage of all points which are outliers to the median with respect 
% to the size of the data
%
% data: the data signal
%
% window: the moving window of the data where full window size 
% is window * 2 centered around any given datapoint during calculation.

numOutliers = isoutlier(data, 'movmedian', window);
percentOutliers = sum(numOutliers) / length(data);

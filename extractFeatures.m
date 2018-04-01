function ret = extractFeatures(data, sampleFrequency)
%EXTRACTFEATURES extracts features for training on the given data
%
% data: the raw sample amplitudes
%
% sampleFrequency: the raw sample frequency

ret = [];

% simple statistics of raw data
ret(getNext(ret, 1)) = abs(mean(data));
ret(getNext(ret, 1)) = std(data);
ret(getNext(ret, 1)) = var(data);

% power of spectral density (fourier transform)
pxx = pwelch(data, [], [], [], sampleFrequency);

ret(getNext(ret, 1)) = mean(pxx);
ret(getNext(ret, 1)) = std(pxx);
ret(getNext(ret, 1)) = var(pxx);

% find the peak powers and location
[peaks, locs] = findpeaks(pxx, sampleFrequency);
% sort by intensity
[sortedPeaks, sortedIndecies] = sort(peaks, 'desc');
sortedLocs = locs(sortedIndecies);

ret(getNext(ret, 9)) = computePeakStatisticsOverBiggestPeaks(sortedPeaks, sortedLocs, length(sortedPeaks));

% 100 largest peaks statistics
ret(getNext(ret, 9)) = computePeakStatisticsOverBiggestPeaks(sortedPeaks, sortedLocs, 100);

% 50 largest peaks statistics
ret(getNext(ret, 9)) = computePeakStatisticsOverBiggestPeaks(sortedPeaks, sortedLocs, 50);

% 10 largest peaks statistics
ret(getNext(ret, 9)) = computePeakStatisticsOverBiggestPeaks(sortedPeaks, sortedLocs, 10);

% absolute value of signal
absData = abs(data);

% peaks of abs ampltude of .10 relative prominance
ret(getNext(ret, 4)) = findPeakDistancesWithMinProminance(absData, sampleFrequency, .1);

% peaks of abs ampltude of .15 relative prominance
ret(getNext(ret, 4)) = findPeakDistancesWithMinProminance(absData, sampleFrequency, .15);

% peaks of abs ampltude of .3 relative prominance
ret(getNext(ret, 4)) = findPeakDistancesWithMinProminance(absData, sampleFrequency, .3);

% peaks of abs ampltude of .05 relative prominance
ret(getNext(ret, 4)) = findPeakDistancesWithMinProminance(absData, sampleFrequency, .05);

% peaks of abs ampltude of .5 relative prominance
ret(getNext(ret, 4)) = findPeakDistancesWithMinProminance(absData, sampleFrequency, .5);

% root mean squared of the data
ret(getNext(ret, 1)) = rms(data);

% Autocorrelation data
xcorrData = xcorr(data);
ret(getNext(ret, 1)) = mean(xcorrData);
ret(getNext(ret, 1)) = std(xcorrData);
ret(getNext(ret, 1)) = var(xcorrData);

% Outliers of moving median data

ret(getNext(ret, 1)) = calculateOutlierRateWithinWindow(data, 100);
ret(getNext(ret, 1)) = calculateOutlierRateWithinWindow(data, 250);
ret(getNext(ret, 1)) = calculateOutlierRateWithinWindow(data, 500);
ret(getNext(ret, 1)) = calculateOutlierRateWithinWindow(data, 1000);
ret(getNext(ret, 1)) = calculateOutlierRateWithinWindow(data, 2500);
ret(getNext(ret, 1)) = calculateOutlierRateWithinWindow(data, 5000);
ret(getNext(ret, 1)) = calculateOutlierRateWithinWindow(data, 10000);

% The average frequency of the data
ret(getNext(ret, 1)) = meanfreq(data, sampleFrequency);

% A measurement of how much this signal deviates over a short period
% of time
ret(getNext(ret, 1)) = mad(data, 100) / length(data);

% error checking
if sum(isnan(ret)) > 0
   disp('Something was NaN');
   disp(ret);
   pause;
end

ret = ret';
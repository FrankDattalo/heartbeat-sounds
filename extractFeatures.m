function ret = extractFeatures(data, sampleFrequency)
%EXTRACTFEATURES extracts features for training on the given data
%
% data: the raw sample amplitudes
%
% sampleFrequency: the raw sample frequency

% simple statistics of raw data
meanAmplitude = abs(mean(data));
stdAmplitude = std(data);
varAmplitude = var(data);

% power of spectral density (fourier transform)
pxx = pwelch(data, [], [], [], sampleFrequency);

meanPowerSpectralDensity = mean(pxx);
stdPowerSpectralDensity = std(pxx);
varPowerSpectralDensity = var(pxx);

% find the peak powers and location
[peaks, locs] = findpeaks(pxx, sampleFrequency);

meanLoc = mean(locs);
stdLoc = std(locs);
varLoc = var(locs);

meanPeak = mean(peaks);
stdPeaks = std(peaks);
varPeaks = var(peaks);
peaksRate = length(locs) / length(data);

% peaks sorted by intensity
[sortedPeaks, sortedIndecies] = sort(peaks, 'desc');
sortedLocs = locs(sortedIndecies);

% 100 largest peaks
upperIndex = min(100, length(sortedIndecies));

firstSortedPeaks = sortedPeaks(1:upperIndex);
firstSortedLocations = sortedLocs(1:upperIndex);

meanFirstPeaks100 = mean(firstSortedPeaks);
stdFirstPeaks100 = std(firstSortedPeaks);
varFirstPeaks100 = var(firstSortedPeaks);

meanFirstLocations100 = mean(firstSortedLocations);
stdFirstLocations100 = std(firstSortedLocations);
varFirstLocations100 = var(firstSortedLocations);

% 50 largest peaks
upperIndex = min(50, length(sortedIndecies));

firstSortedPeaks = sortedPeaks(1:upperIndex);
firstSortedLocations = sortedLocs(1:upperIndex);

meanFirstPeaks50 = mean(firstSortedPeaks);
stdFirstPeaks50 = std(firstSortedPeaks);
varFirstPeaks50 = var(firstSortedPeaks);

meanFirstLocations50 = mean(firstSortedLocations);
stdFirstLocations50 = std(firstSortedLocations);
varFirstLocations50 = var(firstSortedLocations);

% 10 largest peaks
upperIndex = min(10, length(sortedIndecies));

firstSortedPeaks = sortedPeaks(1:upperIndex);
firstSortedLocations = sortedLocs(1:upperIndex);

meanFirstPeaks10 = mean(firstSortedPeaks);
stdFirstPeaks10 = std(firstSortedPeaks);
varFirstPeaks10 = var(firstSortedPeaks);

meanFirstLocations10 = mean(firstSortedLocations);
stdFirstLocations10 = std(firstSortedLocations);
varFirstLocations10 = var(firstSortedLocations);

% peaks of abs ampltude of .10 relative prominance
absData = abs(data);

[~, locs10] = findpeaks(absData, sampleFrequency, ...
    'minpeakprominence', .10);
% remove all NaN peaks
locs10 = dropNaN(locs10);

distances10 = computeDistances(locs10);

meanDistances10 = mean(distances10);
stdDistances10 = std(distances10);
varDistances10 = var(distances10);
relativeMeanDistances10 = meanDistances10 / length(data);

% peaks of abs ampltude of .15 relative prominance

[~, locs15] = findpeaks(absData, sampleFrequency, ...
    'minpeakprominence', .15);
% remove all NaN peaks
locs15 = dropNaN(locs15);

distances15 = computeDistances(locs15);

meanDistances15 = mean(distances15);
stdDistances15 = std(distances15);
varDistances15 = var(distances15);
relativeMeanDistances15 = meanDistances15 / length(data);

% peaks of abs ampltude of .3 relative prominance

[~, locs30] = findpeaks(absData, sampleFrequency, ...
    'minpeakprominence', .3);
% remove all NaN peaks
locs30 = dropNaN(locs30);

distances30 = computeDistances(locs30);

meanDistances30 = mean(distances30);
stdDistances30 = std(distances30);
varDistances30 = var(distances30);
relativeMeanDistance30 = meanDistances30 / length(data);

% peaks of abs ampltude of .05 relative prominance

[~, locs05] = findpeaks(absData, sampleFrequency, ...
    'minpeakprominence', .05);
% remove all NaN peaks
locs05 = dropNaN(locs05);

distances05 = computeDistances(locs05);

meanDistances05 = mean(distances05);
stdDistances05 = std(distances05);
varDistances05 = var(distances05);
relativeMeanDistance05 = meanDistances05 / length(data);

% root mean squared of the data
rmsData = rms(data);

% Autocorrelation data
xcorrData = xcorr(data);
meanXcorrData = mean(xcorrData);
stdXcorrData = std(xcorrData);
varXcorrData = var(xcorrData);

% Outliers of moving median data

outliers100 = isoutlier(data, 'movmedian', 100);
percentOutliers100 = sum(outliers100) / length(data);

outliers250 = isoutlier(data, 'movmedian', 250);
percentOutliers250 = sum(outliers250) / length(data);

outliers500 = isoutlier(data, 'movmedian', 500);
percentOutliers500 = sum(outliers500) / length(data);

outliers1000 = isoutlier(data, 'movmedian', 1000);
percentOutliers1000 = sum(outliers1000) / length(data);

outliers2500 = isoutlier(data, 'movmedian', 2500);
percentOutliers2500 = sum(outliers2500) / length(data);

outliers5000 = isoutlier(data, 'movmedian', 5000);
percentOutliers5000 = sum(outliers5000) / length(data);

% The average frequency of the data
meanFrequency = meanfreq(data, sampleFrequency);

% A measurement of how much this signal deviates over a short period
% of time
percentMovingAbsoluteDeviation = mad(data, 100) / length(data);

N = 59;
ret = zeros(N, 1);
ret(1) = meanAmplitude;
ret(2) = stdAmplitude;
ret(3) = varAmplitude;
ret(4) = meanLoc;
ret(5) = stdLoc;
ret(6) = varLoc;
ret(7) = meanPeak;
ret(8) = stdPeaks;
ret(9) = varPeaks;
ret(10) = meanFirstPeaks10;
ret(11) = stdFirstPeaks10;
ret(12) = varFirstPeaks10;
ret(13) = meanFirstLocations10;
ret(14) = stdFirstLocations10;
ret(15) = varFirstLocations10;
ret(16) = meanFirstPeaks50;
ret(17) = stdFirstPeaks50;
ret(18) = varFirstPeaks50;
ret(19) = meanFirstLocations50;
ret(20) = stdFirstLocations50;
ret(21) = varFirstLocations50;
ret(22) = meanFirstPeaks100;
ret(23) = stdFirstPeaks100;
ret(24) = varFirstPeaks100;
ret(25) = meanFirstLocations100;
ret(26) = stdFirstLocations100;
ret(27) = varFirstLocations100;
ret(28) = rmsData;
ret(29) = meanXcorrData;
ret(30) = stdXcorrData;
ret(31) = varXcorrData;
ret(32) = percentOutliers250;
ret(33) = percentOutliers100;
ret(34) = percentOutliers500;
ret(35) = percentOutliers1000;
ret(36) = percentOutliers2500;
ret(37) = percentOutliers5000;
ret(38) = meanFrequency;
ret(39) = percentMovingAbsoluteDeviation;
ret(40) = peaksRate;
ret(41) = meanPowerSpectralDensity;
ret(42) = stdPowerSpectralDensity;
ret(43) = varPowerSpectralDensity;
ret(44) = meanDistances10;
ret(45) = stdDistances10;
ret(46) = varDistances10;
ret(47) = relativeMeanDistances10;
ret(48) = meanDistances15;
ret(49) = stdDistances15;
ret(50) = varDistances15;
ret(51) = relativeMeanDistances15;
ret(52) = meanDistances30;
ret(53) = stdDistances30;
ret(54) = varDistances30;
ret(55) = relativeMeanDistance30;
ret(56) = meanDistances05;
ret(57) = stdDistances05;
ret(58) = varDistances05;
ret(59) = relativeMeanDistance05;

if sum(isnan(ret)) > 0
   disp('Something was NaN');
   disp(ret);
   pause;
end

ret = ret';
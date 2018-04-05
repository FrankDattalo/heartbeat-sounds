function ret = ...
    findPeakDistancesWithMinProminance(absData, sampleFrequency, prominence)
%FINDPEAKDISTANCESWITHMINPROMINANCE calculates the mean, std, var, and 
% mean / length(data) for all peaks within the data which are at least
% prominence larger than their neighbors
%
% absData: the absolute value of the data signal
%
% sampleFrequency: the sample frequency of the data
%
% prominence: the relative prominence of the peaks

[~, locs] = findpeaks(absData, sampleFrequency, ...
    'minpeakprominence', prominence);
% remove all NaN peaks
locs = dropNaN(locs);

distances = computeDistances(locs);

ret = zeros(3, 1);

ret(1) = mean(distances);
ret(2) = std(distances);
%ret(3) = var(distances);
ret(3) = ret(1) / length(absData);


function ret = ...
    computePeakStatisticsOverBiggestPeaks(sortedPeaks, sortedLocs, biggestN)

%COMPUTEPEAKSTATISTICSOVERBIGGESTPEAKS Computes statistics for the top
%n-many peaks as specified by sortedPeaks and sortedLocs
%
% sortedPeaks: the largest peaks in descending order
%
% sortedLocs: the locations of the largest peaks in descending order
%
% biggestN: the top-N peaks and locations to consider in this calculation


upperIndex = min(biggestN, length(sortedPeaks));

firstSortedPeaks = sortedPeaks(1:upperIndex);
firstSortedLocations = sortedLocs(1:upperIndex);

ret = zeros(6, 1);

ret(1) = mean(firstSortedPeaks);
ret(2) = std(firstSortedPeaks);
%ret(3) = var(firstSortedPeaks);

ret(3) = mean(firstSortedLocations);
ret(4) = std(firstSortedLocations);
%ret(6) = var(firstSortedLocations);

locationDistances = computeDistances(firstSortedLocations);
ret(5) = mean(locationDistances);
ret(6) = var(locationDistances);
%ret(9) = std(locationDistances);

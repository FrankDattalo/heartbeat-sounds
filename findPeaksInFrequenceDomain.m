function ret = findPeaksInFrequenceDomain(data, fs, promience)
%FINDPEAKSINFREQUENCEDOMAIN calculates the pwelch and calculates statistics
%with min promience

pxx = pwelch(data, [], [], fs);

[~, locs] = findpeaks(pxx, 'minpeakprominence', promience);

distances = computeDistances(locs);

ret = zeros(1, 2);

ret(1) = mean(distances);
ret(2) = std(distances);
ret(3) = var(locs);
ret(4) = mean(locs);


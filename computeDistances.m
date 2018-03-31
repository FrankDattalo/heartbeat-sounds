function distances = computeDistances(locs)
%COMPUTEDISTANCES computes the N-1 distances between
% the locations in the locs variables
%
% loc: should be an Nx1 vector of locations

N = length(locs);

if N <= 1
    distances = 0;
    return;
end

distances = zeros(N-1,1);

for i=1:N-1
   distances(i) = abs(locs(i) - locs(i + 1)); 
end


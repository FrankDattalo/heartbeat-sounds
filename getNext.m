function ret = getNext(vect, n)
%GETNEXT utility method to return a vector of N indecies past the 
% length of a given vector
%
% vector: the vector to get the next n many indecies to insert into
%
% n: the number of indecies to extend vect by

currentLength = length(vect);
startIndex = currentLength + 1;
endIndex = currentLength + n;

ret = startIndex:endIndex;


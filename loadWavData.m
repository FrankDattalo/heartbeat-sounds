function data = loadWavData(dataLocation)
%LOADDATA Loads the input data from the given data location and returns
% a struct containing all the data information. The struct contains the 
% following fields:
%
% data: the raw data of the file.
%
% sampleFrequency: the sampling frequency of the data
%
% normal: 1-0 boolean signaling whether the given data point is labeled 
%         as normal.

imported = importdata(dataLocation);

data = struct;
data.data = imported.data;
data.sampleFrequency = imported.fs;
data.normal = contains(dataLocation, 'normal', 'IgnoreCase', true);



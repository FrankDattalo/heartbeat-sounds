%% Introduction
%
% The goal of this script is to expore the capabilities of MATLAB
%

%% Load Data
% 
% Here, We will load a single datapoint in order to view MATLAB's
% exploration and processing techniques


dataLocation = 'heartbeat-sounds/set_b/murmur__112_1306243000964_A.wav';
imported = loadWavData(dataLocation);

data = imported.data;
sampleFrequency = imported.sampleFrequency;
normal = imported.normal;

%% Plot Data
%
% Plotting the Amplitude over time

plot(data);

%% Plot Amilitude Histogram
histogram(data);


%% Creating a Low Pass Filter Over the Data
% All noise higher than some range will be cut out

lpf = lowPassFilter;

%% Create a High Pass Filter Over the Data
% All noise lower than some range will be cut out



%% Filter Data
filtered = filter(lpf, data);

%% Plot Filtered Data
plot(filtered);

%% Plot Spectral Density (Power of Spectral Density)
pwelch(filtered, [], [], [], sampleFrequency);

%% Get Spectral Density of filtered frequency
[pxx, f] = pwelch(filtered, [], [], [], sampleFrequency);

%% Find peak signals
relativeMinPeakDistance = 0.5;
minPeakDistance = floor(relativeMinPeakDistance * length(f) / sampleFrequency);

[peaks, locs] = findpeaks(pxx, sampleFrequency, ...
    'npeaks', 30, ...
    'minpeakdistance', minPeakDistance, ...
    'minpeakprominence', 1e-5);

%% Plot Peak Signals
findpeaks(pxx, sampleFrequency, ...
    'npeaks', 30, ...
    'minpeakdistance', minPeakDistance, ...
    'minpeakprominence', 1e-5);

%% Plot Peaks and locations

plot(locs, peaks);

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


%% Plot Spectral Density (Power of Spectral Density)
[pxx, f] = pwelch(data, [], [], [], sampleFrequency);

%% Find peak signals

findpeaks(abs(data), sampleFrequency, ...
    'minpeakprominence', .15);


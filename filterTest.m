%% Introduction
% 
% The purpose of this script is to experiment with highpass/lowpass
% filtering of the data.


%% Import Data Into Workspace
normal = importdata('./heartbeat-sounds/set_b/normal__103_1305031931979_B.wav');
noisyNormal = importdata('./heartbeat-sounds/set_b/normal_noisynormal_104_1305032492469_A.wav');
extrastole = importdata('./heartbeat-sounds/set_b/extrastole__127_1306764300147_C2.wav');
murmur = importdata('./heartbeat-sounds/set_b/murmur__112_1306243000964_A.wav');

%% Find minimum length for plotting on same scale
minLength = length(normal.data);
minLength = min(minLength, length(noisyNormal.data));
minLength = min(minLength, length(extrastole.data));
minLength = min(minLength, length(murmur.data));

maxAmplitude = max(normal.data);
maxAmplitude = max(maxAmplitude, max(noisyNormal.data));
maxAmplitude = max(maxAmplitude, max(extrastole.data));
maxAmplitude = max(maxAmplitude, max(murmur.data));

minAmplitude = min(normal.data);
minAmplitude = min(minAmplitude, min(noisyNormal.data));
minAmplitude = min(minAmplitude, min(extrastole.data));
minAmplitude = min(minAmplitude, min(murmur.data));

%% Plot Raw Data

figure;
subplot(2, 2, 1);
plot(normal.data(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Normal');

subplot(2, 2, 2);
plot(noisyNormal.data(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Noisy Normal');

subplot(2, 2, 3);
plot(extrastole.data(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Extrasystole');

subplot(2, 2, 4);
plot(murmur.data(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Murmur');


%% Plot Data Scaled By Absolute Max

figure;
subplot(2, 2, 1);
plot(normal.data(1:minLength) / max(abs(normal.data)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Normal');

subplot(2, 2, 2);
plot(noisyNormal.data(1:minLength) / max(abs(noisyNormal.data)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Noisy Normal');

subplot(2, 2, 3);
plot(extrastole.data(1:minLength) / max(abs(extrastole.data)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Extrasystole');

subplot(2, 2, 4);
plot(murmur.data(1:minLength) / max(abs(murmur.data)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Murmur');

%% Low Pass Filter Data

lpf = lowPassFilter;
normalLowFiltered = filter(lpf, normal.data);
noisyNormalLowFiltered = filter(lpf, noisyNormal.data);
extrastoleLowPassFiltered = filter(lpf, extrastole.data);
murmurLowPassFiltered = filter(lpf, murmur.data);

%% Plot Low Pass Filtered Data

figure;
subplot(2, 2, 1);
plot(normalLowFiltered(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Normal');

subplot(2, 2, 2);
plot(noisyNormalLowFiltered(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Noisy Normal');

subplot(2, 2, 3);
plot(extrastoleLowPassFiltered(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Extrasystole');

subplot(2, 2, 4);
plot(murmurLowPassFiltered(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Murmur');

%% Plot Scaled Low Pass Filtered Data

figure;
subplot(2, 2, 1);
plot(normalLowFiltered(1:minLength) / max(abs(normalLowFiltered)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Normal');

subplot(2, 2, 2);
plot(noisyNormalLowFiltered(1:minLength) / max(abs(noisyNormalLowFiltered)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Noisy Normal');

subplot(2, 2, 3);
plot(extrastoleLowPassFiltered(1:minLength) / max(abs(extrastoleLowPassFiltered)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Extrasystole');

subplot(2, 2, 4);
plot(murmurLowPassFiltered(1:minLength) / max(abs(murmurLowPassFiltered)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Murmur');

%% High Pass Filter of Data

hpf = highPassFilter;
normalHighFiltered = filter(hpf, normalLowFiltered);
noisyNormalHighFiltered = filter(hpf, noisyNormalLowFiltered);
extrastoleHighPassFiltered = filter(hpf, extrastoleLowPassFiltered);
murmurHighPassFiltered = filter(hpf, murmurLowPassFiltered);

%% Plot High/Low Filtered Data

figure;
subplot(2, 2, 1);
plot(normalHighFiltered(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Normal');

subplot(2, 2, 2);
plot(noisyNormalHighFiltered(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Noisy Normal');

subplot(2, 2, 3);
plot(extrastoleHighPassFiltered(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Extrasystole');

subplot(2, 2, 4);
plot(murmurHighPassFiltered(1:minLength));
xlim([1, minLength]);
ylim([minAmplitude, maxAmplitude]);
title('Murmur');

%% Plot Scaled High/Low Filtered Data

figure;
subplot(2, 2, 1);
plot(normalHighFiltered(1:minLength) / max(abs(normalHighFiltered)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Normal');

subplot(2, 2, 2);
plot(noisyNormalHighFiltered(1:minLength) / max(abs(noisyNormalHighFiltered)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Noisy Normal');

subplot(2, 2, 3);
plot(extrastoleHighPassFiltered(1:minLength) / max(abs(extrastoleHighPassFiltered)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Extrasystole');

subplot(2, 2, 4);
plot(murmurHighPassFiltered(1:minLength) / max(abs(murmurHighPassFiltered)));
xlim([1, minLength]);
ylim([-1, 1]);
title('Murmur');




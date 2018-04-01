function [x, y] = loadData(baseFolder)
%LOADDATA loads all data in feature-extracted format for traiining.
% 
% baseFolder: The base folder where the data exists

contents = dir(baseFolder);

if ~endsWith(baseFolder, '/')
    baseFolder = strcat(baseFolder, '/');
end

% Get Size Of x and y variables
countLabeled = 0;
for i = 1:length(contents)
    name = strcat(baseFolder, contents(i).name);
    if ~contains(name, 'unlabelled') && contains(name, '.wav')
        countLabeled = countLabeled + 1;
    end
end

% X is all training / test sdata
NUM_FEATURES = 75;
x = zeros(countLabeled, NUM_FEATURES);
y = zeros(countLabeled, 1);

countLabeled = 1;
% do actual loading here
for i = 1:length(contents)
    name = strcat(baseFolder, contents(i).name);
    if ~contains(name, 'unlabelled') && contains(name, '.wav')

        fprintf("Loading %s\n", name);
        imported = loadWavData(name);
        x(i,:) = extractFeatures(imported.data, imported.sampleFrequency);
        y(i) = imported.normal;

        countLabeled = countLabeled + 1;
    end
end

permutedIndecies = randperm(length(x));
x = x(permutedIndecies,:);
y = y(permutedIndecies,:);


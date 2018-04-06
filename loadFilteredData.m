function [x,nny,data] = loadFilteredData(baseFolder)
%LOADFILTEREDDATA loads and filters all data in feature-extracted format for traiining.
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
    NUM_FEATURES = 83;
    NUM_CLASSES = 3;
    x = zeros(countLabeled, NUM_FEATURES);
    y = zeros(countLabeled, 1);
    nny = zeros(countLabeled,NUM_CLASSES);

    countLabeled = 1;
    % do actual loading here
    for i = 1:length(contents)
        name = strcat(baseFolder, contents(i).name);
        if ~contains(name, 'unlabelled') && contains(name, '.wav')

            fprintf("Loading %s\n", name);
            imported = loadWavData(name);
            %lpf = lowPassFilter;
            %filteredData = filter(lpf,imported.data);
            Wn = 195/(imported.sampleFrequency/2);
            %[b,a] = butter(2,Wn,'low');
            [b,a] = cheby1(2,1,Wn,'low');
            filteredData = filter(b,a,imported.data);
            x(countLabeled,:) = extractFeatures(filteredData, imported.sampleFrequency);
            y(countLabeled) = imported.class;
            nny(countLabeled,imported.class) = 1;

            countLabeled = countLabeled + 1;
        end
    end

    permutedIndecies = randperm(length(x));
    x = x(permutedIndecies,:);
    y = y(permutedIndecies,:);
    data = [x y];
end
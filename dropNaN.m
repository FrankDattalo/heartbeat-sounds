function ret = dropNaN(vector)
%DROPNAN returns a filtered vector with all NaNs removed

newLength = length(vector) - sum(isnan(vector));

if newLength < 1
    ret = 0;
    return;
end

writeIndex = 1;
ret = zeros(newLength, 1);

for readIndex = 1:length(vector)
    if ~isnan(vector(readIndex))
        ret(writeIndex) = vector(readIndex);
        writeIndex = writeIndex + 1;
    end
end

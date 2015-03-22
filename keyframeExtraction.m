t = cputime;

numKeys = 10;

setNonKeys = m;
setKeys = [];
indKeys = [];

for indKey = 1 : numKeys
    numNonKeys = size(setNonKeys, 1);    
    results = zeros(numNonKeys, 1);
    for indNonKeys = 1 : numNonKeys
        % currentMotion = setNonKeys(indNonKeys, :);
        if (indNonKeys == 1)
            currentNonKeys = setNonKeys(2:end, :);
            currentKeys = [setKeys; setNonKeys(1, :)];
        elseif (indNonKeys == numNonKeys)
            currentNonKeys = setNonKeys(1:end-1, :);
            currentKeys = [setKeys; setNonKeys(end, :)];
        else
            currentNonKeys = setNonKeys([1:indNonKeys-1, indNonKeys+1:end], :);
            currentKeys = [setKeys; setNonKeys(indNonKeys, :)];
        end
        diffM = currentNonKeys - currentNonKeys*pinv(currentKeys)*currentKeys;
        results(indNonKeys) = sum(sum(diffM.^2));        
    end
    [valueMin, indMin] = min(results);
    if (indMin == 1)
        setNonKeys = setNonKeys(2:end, :);        
    elseif (indMin == numNonKeys)
        setNonKeys = setNonKeys(1:end-1, :);        
    else
        setNonKeys = setNonKeys([1:indMin-1, indMin+1:end], :);        
    end
    setKeys = [setKeys; setNonKeys(indMin, :)];
end

totalT = cputime - t;
disp(['elapsed CPU time', num2str(totalT)]);
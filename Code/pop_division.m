% Done
function [parLen, divSize, maxLen] = pop_division(popSize, nDivision, nFeatures)


%% This Function Is Used To Divide The Population Into Sub-Populations

%% Population Division Procedure
divSize = fix(popSize / nDivision);
maxLen = nFeatures;
len = zeros(1,nDivision);
for v=1:nDivision
    len(v) = maxLen * (v / nDivision);
end
parLen = len;
end
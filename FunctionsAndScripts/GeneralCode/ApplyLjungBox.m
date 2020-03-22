%Applying LjungBoxTest for the project 

AutoCorr_Test = zeros(3,asset);

for j = 1:asset
datapoints = returns(firstData(j):end,j);   
output = LjungBoxTest(datapoints,LengthSignal,0,0.05);
AutoCorr_Test(:,j) = output';
end

clear output
clear datapoints
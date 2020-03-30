%Applying LjungBoxTest for the project 

AutoCorr_Test = zeros(3,asset);

for j = 1:asset
datapoints = returns(firstData(j):end,j);   
output = LjungBoxTest(datapoints,LengthSignal,0,0.05);
AutoCorr_Test(:,j) = output';
end

AutoCorr_Test = AutoCorr_Test';
AutoCorr_Test=array2table(AutoCorr_Test,'RowNames',["BrentOil", "NatGas", "LightCrudeOil", "Gasoline", "GasOil", "HeatingOil", "Coal", "JGB10Y", "US5Y", "US10Y", "US30Y", "COCOA", "COPPER", "CORN", "COTTON", "GOLD", "CATTLE", "SILVER", "SOYBEANS", "SUGAR", "WHEAT", "DAX", "FTSE100", "KOSPI200", "NASDAQ100", "NIKKEI225", "SP500", "CAC40", "AUDUSD", "CADUSD", "CHFUSD", "EURUSD", "GBPUSP", "JPYUSD", "Bitcoin"],'VariableNames',{'Stat','Critical Value','P-Value'});
filename = 'Output/AutoCorr.xlsx';
writetable(AutoCorr_Test,filename,'Sheet',1,'Range','D1','WriteRowNames',true)


clear output
clear datapoints
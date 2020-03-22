%% Plot of the Volatility of the assets

asset = size(returns,2);
Var = zeros(1,asset); 

for i = 1:asset
    Available = find(MonReturn(:,i) ~= 0,1);
    Var(i) = std(MonReturn(Available:end,i));
end 

%Vector of categorical names
names = categorical(names);
names = reordercats(names,["BrentOil", "NatGas", "LightCrudeOil", "Gasoline", "GasOil", ...
    "HeatingOil", "Coal", "JGB10Y", "US5Y", "US10Y", "US30Y", "COCOA", "COPPER", "CORN", "COTTON", ...
    "GOLD", "CATTLE", "SILVER", "SOYBEANS", "SUGAR", "WHEAT", "DAX", "FTSE100", "KOSPI200",...
    "NASDAQ100", "NIKKEI225", "SP500", "CAC40", "AUDUSD", "CADUSD", "CHFUSD", "EURUSD", "GBPUSP", "JPYUSD", "Bitcoin"]);

% Matrix of colors
MatColor = [0.6350,0.0780,0.1840;0.6350,0.0780,0.1840;0.6350,0.0780,0.1840;0.6350,0.0780,0.1840;0.6350,0.0780,0.1840;0.6350,0.0780,0.1840;0.6350,0.0780,0.1840 ...
    ;0.4660,0.6740,0.1880;0.4660 0.6740 0.1880;0.4660 0.6740 0.1880;0.4660 0.6740 0.1880;0.9290,0.6940,0.1250;0.9290,0.6940,0.1250 ...
    ;0.9290,0.6940,0.1250;0.9290,0.6940,0.1250;0.9290,0.6940,0.1250;0.9290,0.6940,0.1250;0.9290,0.6940,0.1250 ...
    ;0.9290,0.6940,0.1250;0.9290,0.6940,0.1250;0.9290,0.6940,0.1250;0.9290,0.6940,0.1250 ...
    ;0.8500,0.3250,0.0980;0.8500,0.3250,0.0980;0.8500,0.3250,0.0980;0.8500,0.3250,0.0980 ...
    ; 0.8500,0.3250,0.0980;0.8500,0.3250,0.0980;0.8500,0.3250,0.0980 ...
    ;0,0.4470,0.7410;0,0.4470,0.7410;0,0.4470,0.7410;0,0.4470,0.7410;0,0.4470,0.7410;0,0.4470,0.7410];

% Bar Plot of the Variance
f = figure('visible','off');
b = bar(names,Var);
b.FaceColor = 'flat';
b.CData(:) = MatColor;
print(f,'Output/Plots/AssetsStandardError', '-dpng', '-r300')

% Bar Plot of the Variance
f = figure('visible','off');
plot(cumprod(returns+1))
print(f,'Output/Plots/Returns', '-dpng', '-r300')

% Plot availability of assets
availablity = isfinite(price); 
f = figure('visible','off');
area(date, availablity)
colormap winter
title('Availability of assets')
xlabel('Years')
ylabel('Number of available assets')
ylim([0 35])
print(f,'Output/Plots/Availability', '-dpng', '-r300')
clear availablity


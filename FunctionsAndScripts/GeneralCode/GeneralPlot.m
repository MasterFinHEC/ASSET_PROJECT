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

% Plot of the correlations 

%Class Construction 
Energy = returns(:,1:7);
FixedIncome = returns(:,8:11);
Commodities = returns(:,12:21);
Equity = returns(:,22:28);
Currency = returns(:,29:35);

% Rolling Window Interclass-pairwise Correlation
IntraCorr = zeros(length(returns)-89,5);
for i = 90:length(returns)
    index = Energy(i,:) ~= 0;
    a = i-89;
    value = Energy(i-89:i,index==1);
    IntraCorr(a,1) = mean(tril(corrcoef(value),-1),'all');
end 
IntraCorr(:,1) = smooth(IntraCorr(:,1));
for i = 90:length(returns)
    index = FixedIncome(i,:) ~= 0;
    a = i-89;
    value = FixedIncome(i-89:i,index==1);
    IntraCorr(a,2) = mean(tril(corrcoef(value),-1),'all');
end 
IntraCorr(:,2) = smooth(IntraCorr(:,2));
for i = 90:length(returns)
    index = Commodities(i,:) ~= 0;
    a = i-89;
    value = Commodities(i-89:i,index==1);
    IntraCorr(a,3) = mean(tril(corrcoef(value),-1),'all');
end 
IntraCorr(:,3) = smooth(IntraCorr(:,3));
for i = 90:length(returns)
    index = Equity(i,:) ~= 0;
    a = i-89;
    value = Equity(i-89:i,index==1);
    IntraCorr(a,4) = mean(tril(corrcoef(value),-1),'all');
end 
IntraCorr(:,4) = smooth(IntraCorr(:,4));
for i = 90:length(returns)
    index = Currency(i,:) ~= 0;
    a = i-89;
    value = Currency(i-89:i,index==1);
    IntraCorr(a,5) = mean(tril(corrcoef(value),-1),'all');
end  
IntraCorr(:,5) = smooth(IntraCorr(:,5));

% All Intracorr
f = figure('visible','off');
plot(date(91:end),IntraCorr)
x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])
print(f,'Output/Plots/AllCorr', '-dpng', '-r300')

% Rolling Window IntraClass Pairwise Correlation
EnergyIntra = mean(Energy,2);
FixedIncomeIntra = mean(FixedIncome,2);
CommoditiesIntra = mean(Commodities,2);
EquityIntra = mean(Equity,2);
CurrencyIntra = mean(Currency,2);
InterCorr = [EnergyIntra, FixedIncomeIntra, CommoditiesIntra, EquityIntra, CurrencyIntra];

f = figure('visible','off');
plot(date(91:end),IntraCorr)
x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])
print(f,'Output/Plots/EnergyCorr', '-dpng', '-r300')











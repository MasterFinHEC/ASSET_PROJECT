%% Plot of the Volatility of the asset

asset = size(returns,2);
Var = zeros(1,asset); 

for i = 1:asset
    Available = find(MonReturn(:,i) ~= 0,1);
    Var(i) = sqrt(12)*std(MonReturn(Available:end,i)-mean(MonReturn(Available:end,i)));
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
    ; 0.8500,0.3250,0.0980;0.8500,0.3250,0.0980;0,0.4470,0.7410 ...
    ;0,0.4470,0.7410;0,0.4470,0.7410;0,0.4470,0.7410;0,0.4470,0.7410;0,0.4470,0.7410;0,0.4470,0.7410];

%% Bar Plot of the Variance


f = figure('visible','off');
b = bar(names,Var);
b.FaceColor = 'flat';
b.CData(:) = MatColor;
title('Assets Volatility')
xlabel('Asset')
ylabel('Volatility')
%legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
%legend([b.SeriesIndex(1),b.SeriesIndex(8), b.SeriesIndex(12), b.SeriesIndex(21), b.SeriesIndex(30)],'Energy','Fixed Income','Commodities','Equity','Currency')
print(f,'Output/Plots/AssetsStandardError', '-dpng', '-r1000')


%% All returns
f = figure('visible','off');
plot(date(2:end),cumprod(returns+1))
title('Cumulative returns of all assets')
xlabel('Years')
ylabel('Cumulative returns (base = 1)')
print(f,'Output/Plots/Returns', '-dpng', '-r1000')

%% Plot availability of assets
availablity = isfinite(price); 
class = zeros(length(availablity),5);

for i = 1:length(availablity)
    class(i,1) = sum(availablity(i,1:7)) ;
     class(i,2) = sum(availablity(i,8:11)) ;
      class(i,3) = sum(availablity(i,12:21)) ;
       class(i,4) = sum(availablity(i,22:28)) ;
        class(i,5) = sum(availablity(i,29:35)) ;
end
%MatColor2 = [0.6350,0.0780,0.1840;0.4660,0.6740,0.1880;0.9290,0.6940,0.1250;0.8500,0.3250,0.0980;0,0.4470,0.7410];
f = figure('visible','off');
area(date, class);
title('Availability of assets')
xlabel('Years')
ylabel('Number of available assets')
ylim([0 35])
x0=10;
y0=10;
width=700;
height=400;
set(gcf,'position',[x0,y0,width,height])
legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
print(f,'Output/Plots/Availability', '-dpng', '-r1000')
clear availablity

%% Plot of the correlations 

% All Intracorr
f = figure('visible','off');
bar(date(91:end),IntraCorr(:,[1,3,4,5]))
title('Average Intra-Class Correlation - 90 days rolling window')
legend('Energy','Commodities','Equity','Currency')
ylabel('Correlation coefficient')
xlabel('Years')
x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])
print(f,'Output/Plots/AllCorr', '-dpng', '-r1000')


% General Inter correlation
f = figure('visible','off');
bar(date(91:end),InterCorrAll)
title('Average 90 days rolling window Inter-class correlation between all asset class')
legend('Average Correlation')
xlabel('Years')
ylabel('Correlation coefficient')
x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])
print(f,'Output/Plots/InterCorr', '-dpng', '-r1000')


%% Sharpe ratio
f = figure('visible','off');
t = tiledlayout(1,2);
title(t,'Sharpe Ratios and correlation regime')
ylabel(t,'Sharpe Ratio')
x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])
ax1 = nexttile;
b = bar(ax1,SharpeTFVPLS(1:3));
title(ax1,'Volatility Parity')
xticklabels(ax1,{'Low','Middle','High'})
ylim(ax1,[0 2])
b.FaceColor = 'flat';
b.CData(:) = [0.9290 0.6940 0.1250;0.8500 0.3250 0.0980;0.6350 0.0780 0.1840];
ax2 = nexttile;
b = bar(ax2,SharpeTFRPLS(1:3));
title(ax2,'Risk Parity')
xticklabels(ax2,{'Low','Middle','High'})
ylim(ax2,[0 2])
b.FaceColor = 'flat';
b.CData(:) = [0.9290 0.6940 0.1250;0.8500 0.3250 0.0980;0.6350 0.0780 0.1840];
print(f,'Output/Plots/SharpeRatios_CorrelationEvent', '-dpng', '-r1000')
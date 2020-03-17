%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EMPIRICAL METHODS FOR FINANCE
% Homework I
%
% Benjamin Souane, Antoine-Michel Alexeev, Ludovic Suchet and ulien Bisch
% Due Date: 5 March 2020
%==========================================================================

close all
clc

addpath(genpath('C:\Users\Benjamin\OneDrive\1. HEC\Master\MScF 4.2\5. QARM\2020\QARM_Project\VolParity'));

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 36);

% Specify sheet and range
opts.Sheet = "Energy";
opts.DataRange = "A1:AJ7946";

% Specify column names and types
opts.VariableNames = ["date", "BrentOil", "NatGas", "LightCrudeOil", "Gasoline", "GasOil", "HeatingOil", "Coal", "Bitcoin", "JGB10Y", "US5Y", "US10Y", "US30Y", "COCOA", "COPPER", "CORN", "COTTON", "GOLD", "CATTLE", "SILVER", "SOYBEANS", "SUGAR", "WHEAT", "DAX", "FTSE100", "KOSPI200", "NASDAQ100", "NIKKEI225", "SP500", "CAC40", "AUDUSD", "CADUSD", "CHFUSD", "EURUSD", "GBPUSP", "JPYUSD"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
%, "GM5Y", "GM10Y" to put back data later on

% Specify variable properties
opts = setvaropts(opts, "date", "InputFormat", "");

% Import the data
QARMDATA = readtable("C:\Users\Benjamin\OneDrive\1. HEC\Master\MScF 4.2\5. QARM\2020\QARM_Project\QARM_DATA.xlsx", opts, "UseExcel", false);
clear opts

%% Creating the vector we will use

txt = QARMDATA.Properties.VariableNames; %Extract the Variables Names
names = txt(2:end); %Vector of Names (Mainly used for plots)
price = table2array(QARMDATA(2:end,2:end)); %Take out the date from the matrix of price
date = datetime(table2array(QARMDATA(2:end,1))); %Vector of date

%% Find the Returns

[returns,firstData] = ReturnNaN(price); %So we have a vector of prices and NaN
%firstdata : Vector with the index of each first data

%% Weights of the volatility parity scheme 

WeightsVolParity = VolParity(returns,firstData); %Used a function to compute the weights

%% Vector of signal

Signal = SignalComputing(returns,firstData); %Computing all the signals 

%% Portfolio volatility to compute leverage

targetVol = 0.1; %Setting the target Volatility

[leverage,PortfolioVol] = Leverage(WeightsVolParity,returns,targetVol); %Finding a vector of leverage, each period.

%% Finding the returns of the strategy 

MonReturn = MonthlyReturns(returns); %Finding Monthly returns of the strategy
Retour = ReturnStrategy(WeightsVolParity,leverage,MonReturn,Signal); %Finding the return of the entire strategy
Date;

%Cumulative Return
cumReturn = cumprod(Retour+1); %Computing the cumulative return

%Plot of the Repartition of weights

WeightsClasses = zeros(385,5);

for i = 1:385
    WeightsClasses(i,1) = sum(WeightsVolParity(i,1:7)) ;
     WeightsClasses(i,2) = sum(WeightsVolParity(i,8:11)) ;
      WeightsClasses(i,3) = sum(WeightsVolParity(i,12:21)) ;
       WeightsClasses(i,4) = sum(WeightsVolParity(i,22:28)) ;
        WeightsClasses(i,5) = sum(WeightsVolParity(i,29:35)) ;
end

%Plot of the Repartition of weights
figure
area(monthdate, WeightsClasses)
colormap winter
% Add a legend
%legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','South','Orientation','horizontal')
% Add title and axis labels
title('Repartition of weights through asset classes')
xlabel('Years')
ylabel('Weights')
ylim([0 1])

%% Find all the other ratios

Margin = MCR(WeightsVolParity,returns,PortfolioVol);

%Plot of the Repartition of weights

MCRClasses = zeros(385,5);

for i = 1:385
    MCRClasses(i,1) = sum(Margin(i,1:7)) ;
     MCRClasses(i,2) = sum(Margin(i,8:11)) ;
      MCRClasses(i,3) = sum(Margin(i,12:21)) ;
       MCRClasses(i,4) = sum(Margin(i,22:28)) ;
        MCRClasses(i,5) = sum(Margin(i,29:35)) ;
end

%Plot of the Repartition of weights
figure
area(monthdate(8:end), MCRClasses(8:end,:))
colormap winter
% Add a legend
%legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','South','Orientation','horizontal')
% Add title and axis labels
title('Repartition of MCR through asset classes')
xlabel('Years')
ylabel('Weights')
ylim([-10 110])

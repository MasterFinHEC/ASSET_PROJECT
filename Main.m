%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EMPIRICAL METHODS FOR FINANCE
% Homework I
%
% Benjamin Souane, Antoine-Michel Alexeev, Ludovic Suchet and Julien Bisch
% Due Date: 5 March 2020
%==========================================================================

close all
clc

addpath(genpath('C:\Users\Benjamin\OneDrive\1. HEC\Master\MScF 4.2\5. QARM\2020\QARM_Project\VolParity'));
addpath(genpath('C:\Users\Benjamin\OneDrive\1. HEC\Master\MScF 4.2\5. QARM\2020\QARM_Project\RiskParit'));
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

%% Computing the the Returns and other usefull vectors

[returns,firstData] = ReturnNaN(price); %So we have a vector of prices and NaN
%firstdata : Vector with the index of each first data

%Generating date 
Date;

%% Volatility Parity

%Computing the Weights of the strategy
WeightsVolParity = VolParity(returns,firstData); %Used a function to compute the weights

%Computing the vector of signals
Signal = SignalComputing(returns,firstData); %Computing all the signals 

targetVol = 0.1; %Setting the target Volatility

%Leverage and portfolio Volatility
[leverage,PortfolioVol] = Leverage(WeightsVolParity,returns,targetVol); %Finding a vector of leverage, each period.

% Finding the returns of the strategy 
MonReturn = MonthlyReturns(returns); %Finding Monthly returns of the strategy
Retour = ReturnStrategy(WeightsVolParity,leverage,MonReturn,Signal); %Finding the return of the entire strategy
Date;

%Cumulative Return
cumReturn = cumprod(Retour+1); %Computing the cumulative return

%Computing the marginal contribution to risk
Margin = MCR(WeightsVolParity,returns,PortfolioVol);

PlotVolParity;

%% Risk parity

%Finding the optimal weights through FminCon optimisation
RiskPar = RiskParityOpti(Signal,WeightsVolParity,returns,targetVol);

%Finding the grossweights in %
GrossRiskPar = abs(RiskPar);
for i = 1:length(GrossRiskPar)
    total = sum(GrossRiskPar(i,:));
    GrossRiskPar(i,:) = GrossRiskPar(i,:)*100/total;
end

%Finding the leverage and the portfolio Volatility
[LeverageRiskParity,PortfolioVolRiskPar] = Leverage(RiskPar,returns,targetVol); 

%Computing the return of the strategy 
ReturnRiskParity = ReturnStrategyRiskPar(RiskPar,LeverageRiskParity,MonReturn);

%Cumulative Return
CumuReturnRiskPar = cumprod(1+ReturnRiskParity);

%Marginal Contribution to risk
MarginRiskParity = MCR(RiskPar,returns,PortfolioVolRiskPar);

PlotRiskParity;

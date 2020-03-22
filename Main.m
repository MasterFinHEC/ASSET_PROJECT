%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quantitative Asset And Risk Management 
% Asset Project - Trend Following (Baltas 2015) 
%
% Benjamin Souane, Antoine-Michel Alexeev, Ludovic Suchet and Julien Bisch
% Due Date: April 2020
%==========================================================================

close all
clc

%Path of the functions and scripts
addpath(genpath('C:\Users\Benjamin\OneDrive\1. HEC\Master\MScF 4.2\5. QARM\2020\QARM_Project\FunctionsAndScripts'))

%Path of KevinSheperd ToolBox
addpath(genpath('C:\Users\Benjamin\OneDrive\1. HEC\Master\MScF 4.2\EMF\2020\Homeworks\KevinSheperdToolBox'))

%% Import the data and setting the parameters of the strategy

%Importing the data and creating the matrix we will use
DataImport; 

% Setting up the value that we will use throughout the script
LengthSignal = 252; % Number of days for the signal 
LengthMonth = 21; % Avg. Number of days in a month
LengthVol = 60; % Number of days to compute the volatility
targetVol = 0.10; %Setting the target Volatility

% Useful Parameters Used throughout the code
asset = size(price,2);

%% Computing the the Returns, a vector with the index of the first available data and a vector of the date of rebalancing

%Computing the returns and the index of availability of the assets
[returns,firstData] = ReturnNaN(price); %So we have a vector of prices and NaN

%Generating date of rebalancing 
Date;

%% Testing the Auto-correlation of the data 

%Apply LjungBoxTest
ApplyLjungBox;

%% Volatility Parity

%Computing the Weights of the strategy
WeightsVolParity = VolParity(returns,firstData,LengthSignal,LengthVol,LengthMonth); %Used a function to compute the weights

% Computing the vector of signals
Signal = SignalComputing(returns,firstData,LengthSignal,LengthMonth); %Computing all the signals 

% Leverage and portfolio Volatility
[leverage,PortfolioVol] = Leverage(WeightsVolParity,returns,targetVol,LengthSignal,LengthVol,LengthMonth); %Finding a vector of leverage, each period.

% Finding the returns of the strategy 
MonReturn = MonthlyReturns(returns,LengthSignal,LengthMonth); %Finding Monthly returns of the strategy
Retour = ReturnStrategy(WeightsVolParity,leverage,MonReturn,Signal); %Finding the return of the entire strategy

% Finding the returns of the Long only Strategy
ReturnLO = ReturnStrategyLONGONLY(WeightsVolParity,leverage,MonReturn);

%Cumulative Return
cumReturn = cumprod(Retour+1); %Computing the cumulative return
cumReturnLO = cumprod(ReturnLO+1); %Computing the cumulative return

%Computing the marginal contribution to risk
MarginContribRisk = MCR(WeightsVolParity,returns,PortfolioVol,LengthSignal,LengthVol,LengthMonth);

%Rescaled Magrinal contribution
total = sum(MarginContribRisk,2);
Margin =  MarginContribRisk.*100./total;

%Ploting the results
PlotVolParity;

%% Risk parity

%Finding the optimal weights through FminCon optimisation
RiskPar = RiskParityOpti(Signal,WeightsVolParity,returns,targetVol,LengthSignal,LengthVol,LengthMonth);

%Finding the leverage and the portfolio Volatility
[LeverageRiskParity,PortfolioVolRiskPar] = Leverage(RiskPar,returns,targetVol,LengthSignal,LengthVol,LengthMonth); 

%Computing the return of the strategy 
ReturnRiskParity = ReturnStrategyRiskPar(RiskPar,LeverageRiskParity,MonReturn);


%Cumulative Return
CumuReturnRiskPar = cumprod(1+ReturnRiskParity);

%Marginal Contribution to risk
MarginRisk = MCR(RiskPar,returns,PortfolioVolRiskPar,LengthSignal,LengthVol,LengthMonth);

%Rescaled Magrinal contribution
total = sum(MarginRisk,2);
MarginRiskParity =  MarginRisk.*100./total;

%Plotting the results
PlotRiskParity;
GeneralPlot;

%End of the code 
disp('Code sucessfully terminated !')
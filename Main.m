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
addpath(genpath('C:\Users\Benjamin\OneDrive\Documents\GitHub\ASSET_PROJECT\FunctionsAndScripts'))

%Path of KevinSheperd ToolBox
addpath(genpath('C:\Users\Benjamin\OneDrive\1. HEC\Master\MScF 4.2\EMF\2020\Homeworks\KevinSheperdToolBox'))

%% Import the data and setting the parameters of the strategy

%Importing the data and creating the matrix we will use
DataImport; 

% Setting up the value that we will use throughout the script
LengthSignal = 252; % Number of days for the signal 
LengthMonth = 21; % Avg. Number of days in a month
LengthVol = 63; % Number of days to compute the volatility
targetVol = 0.10; %Setting the target Volatility

% Useful Parameters Used throughout the code
asset = size(price,2);

%% Computing the the Returns, a vector with the index of the first available data and a vector of the date of rebalancing

%Computing the returns and the index of availability of the assets
[returns,firstData] = ReturnNaN(price); %So we have a vector of prices and NaN

%Generating date of rebalancing 
Date;

%Testing Autocorrelation of Data
ApplyLjungBox;

%% Volatility Parity

% 1. This part compute the volatility using the actual weights applied on
% the 3 previous month returns

%Computing the Weights of the strategy
WeightsVolParity = VolParity(returns,firstData,LengthSignal,...
                             LengthVol,LengthMonth); %Used a function to compute the weights

% Computing the vector of signals
Signal = SignalComputing(returns,firstData,LengthSignal,LengthMonth); %Computing all the signals 

% Leverage and portfolio Volatility
[leverage,PortfolioVol] = Leverage(WeightsVolParity,returns,targetVol,...
                                   Signal,LengthSignal,LengthVol,LengthMonth); %Finding a vector of leverage, each period.

% Finding the returns of the strategy 
MonReturn = MonthlyReturns(returns,LengthSignal,LengthMonth); %Finding Monthly returns of the strategy
ReturnTFLS = ReturnStrategy(WeightsVolParity,leverage,MonReturn,Signal); %Finding the return of the entire strategy

% Finding the returns of the Long only Strategy
ReturnTFLO = ReturnStrategyLONGONLY(WeightsVolParity,leverage,MonReturn);

%Cumulative Return
cumReturnTFLS = cumprod((ReturnTFLS+1)).*100; %Computing the cumulative return
cumReturnTFLO = cumprod((ReturnTFLO+1)).*100; %Computing the cumulative return

%Computing the marginal contribution to risk
[MarginContribRisk,MarginConRiskScaled] = MCR(WeightsVolParity,returns,...
                                              targetVol,LengthSignal,...
                                              LengthVol,LengthMonth);


% 2. This second part compute the volatility using the 3 previous weights
% applied on the three previous month of returns

% The computations of the signals and the weights don't change, we just
% need to be careful with the indexes. 

% a. Leverage Computations -> We will create another functions since it
%    doesn't match well with the other. 

LeverageBaltasVolPar = LeverageBaltas(returns,LengthSignal,LengthMonth,...
                            LengthVol,WeightsVolParity,Signal,targetVol);

% b. Computing the return of the strategy. 
ReturnBaltasStrategy = ReturnBaltas(LeverageBaltasVolPar,MonReturn,Signal,WeightsVolParity);

% Computing Cumulative Returns
CumReturnLSTFB = cumprod((ReturnBaltasStrategy+1)).*100;

%Ploting the results
PlotVolParity;
%% Risk parity

%Finding the optimal weights through FminCon optimisation
RiskPar = RiskParityOpti(Signal,WeightsVolParity,returns,targetVol,...
                          LengthSignal,LengthVol,LengthMonth);

%Finding the leverage and the portfolio Volatility
[LeverageRiskPar,PortfolioVolRiskPar] = LeverageRiskParity(RiskPar,returns,...
                                                           targetVol,LengthSignal,...
                                                           LengthVol,LengthMonth); 

%Computing the return of the strategy 
ReturnRiskParity = ReturnStrategyRiskPar(RiskPar,LeverageRiskPar,MonReturn);

%Cumulative Return
CumuReturnRiskPar = cumprod(1+ReturnRiskParity).*100;

%Marginal Contribution to risk
[MarginRisk,MargConRiskScaledParity] = MCR(RiskPar,returns,PortfolioVol,...
                                           LengthSignal,LengthVol,LengthMonth);

                                       
% 2. Computing with the second type of volatility
%RiskParityWeightsBaltas = RiskParityOptiBaltas(Signal,WeightsVolParity,returns,...
                                               %targetVol,LengthSignal, ...
                                               %LengthVol,LengthMonth);


%Plotting the results
PlotRiskParity;
GeneralPlot;

%Clearing Variables
clear i j total Available b f;

%End of the code 
disp('Code sucessfully terminated !')
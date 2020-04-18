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
addpath(genpath('C:\Users\Benjamin\OneDrive\Documents\GitHub\ASSET_PROJECT'))

%Path of KevinSheperd ToolBox
addpath(genpath('C:\Users\Benjamin\OneDrive\1. HEC\Master\MScF 4.2\EMF\2020\Homeworks\KevinSheperdToolBox'))


%% Import the data and setting the parameters of the strategy

disp('Importing the data.');
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

disp('Computing the matrix of returns.')
%Computing the returns and the index of availability of the assets
[returns,firstData] = ReturnNaN(price); %So we have a vector of prices and NaN

%Computing the monthly returns of the dataset
MonReturn = MonthlyReturns(returns,LengthSignal,LengthMonth); %Finding Monthly returns of the strategy

%Generating date of rebalancing 
Date;

disp('Computing the matrix of momentum signal.')
% Computing the vector of signals
Signal = SignalComputing(returns,firstData,LengthSignal,LengthMonth); %Computing all the signals 

%% Volatility Parity. 

disp('Computing the volatility parity allocation.')
% Computing the wieghts and risk allocation 
[NetWeightsVolParity,GrossWeightsVolParity,MCRVolParity] = Allocation_VolParity(returns,...
    firstData,LengthSignal,LengthVol,LengthMonth,Signal);

% Computing the running volatility and leverage of the strategy
LevVolParity = Leverage(returns,LengthSignal,LengthMonth,LengthVol,NetWeightsVolParity,targetVol);

% Compuginb the leverage of the long only Strategy
LevVolParityLO = Leverage(returns,LengthSignal,LengthMonth,LengthVol,GrossWeightsVolParity,targetVol);

%% Risk Parity.

disp('Computing the risk parity allocation.')
%Setting up a riskfree-rate
RiskFreeRate = 0.01;

%Computing the correlations
Inter_Intra_Correlation;

%Computing the long-only allocation
[NetWeightsRiskParityLO,MCRRiskParityLO] = RiskParityOptiLongOnly(GrossWeightsVolParity,returns,targetVol,...
                          LengthSignal,LengthVol,LengthMonth);

LevRiskParityLO = Leverage(returns,LengthSignal,LengthMonth,LengthVol,NetWeightsRiskParityLO,targetVol);

%Finding the optimal weights through FminCon optimisation
[NetWeightsRiskParity,MCRRiskParity] = RiskParityOpti(NetWeightsVolParity,returns,targetVol,...
                        LengthSignal,LengthVol,LengthMonth);
                      
%[NetWeightsRiskParity,MCRRiskParity] = RiskParityOpti_gridSearch(NetWeightsVolParity,returns,targetVol,LengthSignal,LengthVol,LengthMonth,MonReturn,RiskFreeRate)   ;              


%Computing the leverage of the strategy
LevRiskParity = Leverage(returns,LengthSignal,LengthMonth,LengthVol,NetWeightsRiskParity,targetVol);

%% Portfolio Performance computations

disp('Computing the performance of the portfolios !')

% Volatility Parity Long Short
[ReturnTFVPLS,CumReturnTFVPLS,StatsTFVPLS] = PortfolioStatistics(MonReturn,NetWeightsVolParity,LevVolParity);
[SharpeTFVPLS,~,~] = CorrelationEvent(LengthSignal,LengthMonth,InterCorrAll,ReturnTFVPLS,RiskFreeRate);

% Volatility Parity Long Only
[ReturnTFVPLO,CumReturnTFVPLO,StatsTFVPLO] = PortfolioStatistics(MonReturn,GrossWeightsVolParity,LevVolParityLO);
[SharpeTFVPLO,~,~] = CorrelationEvent(LengthSignal,LengthMonth,InterCorrAll,ReturnTFVPLO,RiskFreeRate);

% Risk Parity
[ReturnTFRPLS,CumReturnTFRPLS,StatsTFRPLS] = PortfolioStatistics(MonReturn,NetWeightsRiskParity,LevRiskParity);
[SharpeTFRPLS,~,~] = CorrelationEvent(LengthSignal,LengthMonth,InterCorrAll,ReturnTFRPLS,RiskFreeRate);

% Risk Parity LO
[ReturnTFRPLO,CumReturnTFRPLO,StatsTFRPLO] = PortfolioStatistics(MonReturn,NetWeightsRiskParityLO,LevRiskParityLO);
[SharpeTFRPLO,~,~] = CorrelationEvent(LengthSignal,LengthMonth,InterCorrAll,ReturnTFRPLO,RiskFreeRate);


%% Extension : Introducing Fees to the model

disp('Computing the fees.')
% This part allows us to compute fees in basis point that we will substract
% to the non-fees return.

%Setting the fees values - different value for long-short and type of
%investor
BpFees = [0.0001, 0.0003];
BpFeesIndividual = [0.001, 0.003];

ApplyFees;
%% Market neutrality

Benchmark;

%% Plotting the results

disp('Plotting the results.')
% Plots of input data
GeneralPlot;

% Plots of Weights and MCR
WeightsAndMCRPlots;

% Plots the of the returns
PlotProject;

%Creating latex table
tabletolatex3;

% Plots of the constrained model
disp('Task succesfully terminated :).');

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

%Computing the monthly returns of the dataset
MonReturn = MonthlyReturns(returns,LengthSignal,LengthMonth); %Finding Monthly returns of the strategy

%Generating date of rebalancing 
Date;

disp('Testing for auto-correlations :')

%Testing Autocorrelation of Data
ApplyLjungBox;

%% Volatility Parity

disp('Computing the volatility Parity Model :')

% 1. This part compute the volatility using the actual weights applied on
% the 3 previous month returns

% Long-Short Volatility Parity
VolParityComputations;

% Long-Only Volatility Parity
VolParityLongOnlyComputations;
                                                 
% 2. This second part compute the volatility using the 3 previous weights
% applied on the three previous month of returns

VolParityBaltasWayComputations;


%% Risk parity

disp('Computing the Risk Parity Model :')

% 1. This part compute the volatility using the actual weights applied on
% the 3 previous month returns

RiskParityComputations;

% 2. This second part compute the volatility using the 3 previous weights
% applied on the three previous month of returns

RiskParityBaltasComputations;

%% Model Extension - Introducing Fees

disp('Computing the extension of the model with the fees :')

%Setting the fees values (different value for long-short)
BpFees = [0.01, 0.03];

%Computing the fees
Fees_VolRiskParity;

%% Model Extension - Constraint on turnover and Constraint + Fees

disp('Computing the extension of the model with the constraint on turnover :')

%Setting Up turnover Target
TargetTurnover = 20;

%Computing the model
ConstraintTurnoverModel;


%% Statistics of Portfolios

disp('Computing Portfolio Statistics :')

StatisticsComputations;

%% Ploting the results

disp('Ploting the results :')

Fees_Plots;
MainPlots;
WeightsAndMCRPlots;
Plot_ConstraintRiskParity;
GeneralPlot;
tabletolatex2;

%Clearing Variables
clear i j total Available b f;

%End of the code 
disp('Code sucessfully terminated !')
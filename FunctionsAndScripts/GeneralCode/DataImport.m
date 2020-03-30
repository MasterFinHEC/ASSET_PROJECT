% This code import the data and create the vector use in the script

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 36);

% Specify sheet and range
opts.Sheet = "Energy";
opts.DataRange = "A1:AJ7946";

% Specify column names and types
opts.VariableNames = ["date", "BrentOil", "NatGas", "LightCrudeOil", "Gasoline", "GasOil", "HeatingOil", "Coal", "JGB10Y", "US5Y", "US10Y", "US30Y", "COCOA", "COPPER", "CORN", "COTTON", "GOLD", "CATTLE", "SILVER", "SOYBEANS", "SUGAR", "WHEAT", "DAX", "FTSE100", "KOSPI200", "NASDAQ100", "NIKKEI225", "SP500", "CAC40", "AUDUSD", "CADUSD", "CHFUSD", "EURUSD", "GBPUSP", "JPYUSD", "Bitcoin"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
%, "GM5Y", "GM10Y" to put back data later on

% Specify variable properties
opts = setvaropts(opts, "date", "InputFormat", "");

% Import the data
QARMDATA = readtable("C:\Users\Benjamin\OneDrive\Documents\GitHub\ASSET_PROJECT\QARM_DATA.xlsx", opts, "UseExcel", false);
clear opts

%% Creating the vector and parameters we will use :

txt = QARMDATA.Properties.VariableNames; %Extract the Variables Names
names = txt(2:end); %Vector of Names (Mainly used for plots)
price = table2array(QARMDATA(2:end,2:end)); %Take out the date from the matrix of price
date = datetime(table2array(QARMDATA(2:end,1))); %Vector of date
clear QARMDATA;
clear txt;
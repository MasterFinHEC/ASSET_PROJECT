%% Computing the strategy correlation with main indexes


%% Setup the Import Options and import the data - Daily Index
opts = spreadsheetImportOptions("NumVariables",5);

% Specify sheet and range
opts.Sheet = "BenchMarks";
opts.DataRange = "A1:E7957";

% Specify column names and types
opts.VariableNames = ["date","MSCIW","MSCIEM","COMMO","BOND"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "date", "InputFormat", "");

% Import the data
QARMDATA = readtable("C:\Users\Benjamin\OneDrive\Documents\GitHub\ASSET_PROJECT\QARM_DATA.xlsx", opts, "UseExcel", false);
clear opts

%% Setup the Import Options and import the data - Monthly Index
opts = spreadsheetImportOptions("NumVariables",2);

% Specify sheet and range
opts.Sheet = "BenchMarks";
opts.DataRange = "F1:G366";

% Specify column names and types
opts.VariableNames = ["date","FX"];
opts.VariableTypes = ["datetime", "double"];

% Specify variable properties
opts = setvaropts(opts, "date", "InputFormat", "");

% Import the data
QARMDATA_2 = readtable("C:\Users\Benjamin\OneDrive\Documents\GitHub\ASSET_PROJECT\QARM_DATA.xlsx", opts, "UseExcel", false);
clear opts

%% Creating the indexes vector 
QARMDATA = table2array(QARMDATA(2:end,2:end));
QARMDATA_2 = table2array(QARMDATA_2(2:end,2:end));

position = 1;
for i = LengthSignal:LengthMonth:size(QARMDATA,1)-1
MSCIWORLD(position,1) = QARMDATA(i,1);
MSCIEM(position,1) = QARMDATA(i,2);
COMMOINDEX(position,1) = QARMDATA(i,3);
BONDINDEX(position,1) = QARMDATA(i,4);
position = position + 1;
end
FXINDEX = QARMDATA_2(2:end,1);

clear QARMDATA QARMDATA_2 position;

%% Computing the strategies Autocorrelation

ReturnBaltasStrategy
ReturnBaltasStrategyRiskParity
ReturnTFLO

Neutral = zeros(5,3);
position = 1;
for i = [MSCIWORLD,MSCIEM,COMMOINDEX,BONDINDEX,FXINDEX]
    if i ~= FXINDEX
temp = corrcoef(ReturnBaltasStrategy,i(4:end)); 
Neutral(position,1) = temp(2,1);
temp = corrcoef(ReturnBaltasStrategyRiskParity,i(4:end));
Neutral(position,2) = temp(2,1);
temp = corrcoef(ReturnTFLO,i(2:end));
Neutral(position,3) = temp(2,1);
position = position + 1; 
    else 
temp = corrcoef(ReturnBaltasStrategy,i); 
Neutral(position,1) = temp(2,1);
temp = corrcoef(ReturnBaltasStrategyRiskParity,i);
Neutral(position,2) = temp(2,1);
temp = corrcoef(ReturnTFLO(3:end),i);
Neutral(position,3) = temp(2,1);
position = position + 1;      
    end
end

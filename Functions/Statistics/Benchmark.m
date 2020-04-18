%% Computing correlation with BenchMarks

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 7);

% Specify sheet and range
opts.Sheet = "BenchMarks";
opts.DataRange = "A2:G7957";

% Specify column names and types
opts.VariableNames = ["date", "MSCIWORLDUTOTRETURNIND", "MSCIEMUTOTRETURNIND", "SPGSCICommodityTotalReturnRETURNINDOFCL", "JPMGBIGlobalAllTradedIndexLevel", "VarName6", "USNOMINALADVANCEDFOREIGNECONOMIESDOLLARINDEXNADJ"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "datetime", "double"];

% Specify variable properties
opts = setvaropts(opts, "date", "InputFormat", "");
opts = setvaropts(opts, "VarName6", "InputFormat", "");

% Import the data
QARMDATAS1 = readtable("C:\Users\Benjamin\OneDrive\Documents\GitHub\ASSET_PROJECT\QARM_DATA.xlsx", opts, "UseExcel", false);

BenchMarks = QARMDATAS1(2:end,[2,3,4,5,7]);
BenchMarks = table2array(BenchMarks);
[Benreturns,BenfirstData] = ReturnNaN(BenchMarks);

clear opts QARMDATAS1 BenchMarks

%% Computing correlation

%Computing the monthly returns of the dataset
B = MonthlyReturns(Benreturns,LengthSignal,LengthMonth);

NeutralTFVPLS = BenchMarkCorrelation(ReturnTFVPLS,B);
NeutralTFVPLO = BenchMarkCorrelation(ReturnTFVPLO,B);
NeutralTFRPLS = BenchMarkCorrelation(ReturnTFRPLS,B);
NeutralTFRPLO = BenchMarkCorrelation(ReturnTFRPLO,B);

NeutralVol = array2table([NeutralTFVPLS(1:4);NeutralTFVPLO(1:4)],'RowNames',{'TFVPLS','TFVPLO'},'VariableNames',{'MSCI World','MSCI EM','SP GSCI Commo.','JPM Global All traded Bonds'});
NeutralRisk = array2table([NeutralTFRPLS(1:4);NeutralTFRPLO(1:4)],'RowNames',{'TFRPLS','TFRPLO'},'VariableNames',{'MSCI World','MSCI EM','SP GSCI Commo.','JPM Global All traded Bonds'});

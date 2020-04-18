%Computing Inter and Intra Correlation
Inter_Intra_Correlation;

%Computing the turnovers of the strategies
NetWeightsVolParity = Signal.*WeightsVolParity;
[AverageTurnoverRiskParity,TurnoverRiskParity] = turnover(MonReturn,WeightsRiskParity);
[AverageTurnoverVolParity,TurnoverVolParity] = turnover(MonReturn,NetWeightsVolParity);
[AverageTurnoverLongOnly,TurnoverLongOnly] = turnover(MonReturn,WeightsVolParity);

%Computing the correlations events Sharpe ratios
[SharpeMeanEvent_VolParity,Sharpe_VolParity,Count_VolParity] = CorrelationEvent(LengthSignal,LengthMonth,...
                                        InterCorrAll,ReturnBaltasStrategy,0.01);
[SharpeMeanEvent_RiskParity,Sharpe_RiskParity,Count_RiskParity] = CorrelationEvent(LengthSignal,LengthMonth,...
                                        InterCorrAll,ReturnBaltasStrategyRiskParity,0.01);                                    

% Computing the annualized mean    
Mean_VolParBaltas = prod(ReturnBaltasStrategy+1)^(1/(length(ReturnBaltasStrategy)/12))-1;
Mean_RiskParBaltas = prod(ReturnBaltasStrategyRiskParity+1)^(1/(length(ReturnBaltasStrategyRiskParity)/12))-1;
Mean_LongOnly = prod(ReturnTFLO+1)^(1/(length(ReturnTFLO)/12))-1;

%Annualized Volatility
Vola_VolParBaltas = std(ReturnBaltasStrategy)*sqrt(12);
Vola_RiskParBaltas = std(ReturnBaltasStrategyRiskParity)*sqrt(12);
Vola_LongOnly = std(ReturnTFLO)*sqrt(12);

% Computing the total Sharpe Ratios
SharpeRatio_VolParBaltas = SharpeRatio(ReturnBaltasStrategy,0.01);
SharpeRatio_RiskParBaltas = SharpeRatio(ReturnBaltasStrategyRiskParity,0.01);
SharpeRatio_LongOnly = SharpeRatio(ReturnTFLO,0.01);

% Computing the Maximum DrawDowns
MDD_VolParityBaltas = MDD(ReturnBaltasStrategy);
MDD_RiskParityBaltas = MDD(ReturnBaltasStrategyRiskParity);
MDD_VolParityLongOnly = MDD(ReturnTFLO);

%CalmarRatio
Calmar_VolParBaltas = Mean_VolParBaltas/MDD_VolParityBaltas;
Calmar_RiskParBaltas = Mean_RiskParBaltas/MDD_RiskParityBaltas;
Calmar_LongOnly = Mean_LongOnly/MDD_VolParityLongOnly;


% Computing the Kurtosis 
Kur_VolParityBaltas = kurtosis(ReturnBaltasStrategy);
Kur_RiskParityBaltas = kurtosis(ReturnBaltasStrategyRiskParity);
Kur_VolParityLongOnly = kurtosis(ReturnTFLO);

% Computing the Skewness
Skew_VolParityBaltas = skewness(ReturnBaltasStrategy);
Skew_RiskParityBaltas = skewness(ReturnBaltasStrategyRiskParity);
Skew_VolParityLongOnly = skewness(ReturnTFLO);

%Creating a dataset for the LO vs. LS statistics
Stat_LOLS = [AverageTurnoverVolParity,AverageTurnoverLongOnly;...
    Mean_VolParBaltas,Mean_LongOnly; ...
    Vola_VolParBaltas,Vola_LongOnly; ...
    SharpeRatio_VolParBaltas,SharpeRatio_LongOnly;...
    Calmar_VolParBaltas,Calmar_LongOnly; ...
    Kur_VolParityBaltas,Kur_VolParityLongOnly;...
    Skew_VolParityBaltas,Skew_VolParityLongOnly;...
    MDD_VolParityBaltas,MDD_VolParityLongOnly];

Stat_LOLS=array2table(Stat_LOLS,'RowNames',{'Average Monthly Turnover %',...
    'Annualized Mean','Annualized Volatility','Sharpe Ratio','Calmar Ratio'...
    ,'Kurtosis','Skewness','Maximum DrawDown'},'VariableNames',{'TFVPLS','TFVPLO'});
filename = 'Output/Stat_LOLS.xlsx';
writetable(Stat_LOLS,filename,'Sheet',1,'Range','D1','WriteRowNames',true)

%Creating a dataset for the VP vs. RP statistics
Stat_VPRP = [AverageTurnoverVolParity,AverageTurnoverRiskParity;...
    Mean_VolParBaltas,Mean_RiskParBaltas; ...
    Vola_VolParBaltas,Vola_RiskParBaltas; ...
    SharpeRatio_VolParBaltas,SharpeRatio_RiskParBaltas;...
    Calmar_VolParBaltas,Calmar_RiskParBaltas; ...
    Kur_VolParityBaltas,Kur_RiskParityBaltas;...
    Skew_VolParityBaltas,Skew_RiskParityBaltas;...
    MDD_VolParityBaltas,MDD_RiskParityBaltas];

Stat_VPRP=array2table(Stat_VPRP,'RowNames',{'Average Monthly Turnover %',...
    'Annualized Mean','Annualized Volatility','Sharpe Ratio','Calmar Ratio'...
    ,'Kurtosis','Skewness','Maximum DrawDown'},'VariableNames',{'TFVPLS','TFRPLS'});
filename = 'Output/Stat_VPRP.xlsx';
writetable(Stat_VPRP,filename,'Sheet',1,'Range','D1','WriteRowNames',true)


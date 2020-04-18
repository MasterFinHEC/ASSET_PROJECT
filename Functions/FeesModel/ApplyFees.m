% Volatility Parity - Long Short
FeesPro_TFVPLS = FeesComputation(BpFees,NetWeightsVolParity);
FeesIndividual_TFVPLS = FeesComputation(BpFeesIndividual,NetWeightsVolParity);
Corrected_returns_TFVPLS_pro = ReturnTFVPLS - FeesPro_TFVPLS(4:end-1);
Corrected_returns_TFVPLS_individual = ReturnTFVPLS - FeesIndividual_TFVPLS(4:end-1);

% Volatility Parity - Long only 
FeesPro_TFVPLO = FeesComputation(BpFees,GrossWeightsVolParity);
FeesIndividual_TFVPLO = FeesComputation(BpFeesIndividual,GrossWeightsVolParity);
Corrected_returns_TFVPLO_pro = ReturnTFVPLO - FeesPro_TFVPLO(4:end-1);
Corrected_returns_TFVPLO_individual = ReturnTFVPLO - FeesIndividual_TFVPLO(4:end-1);

% Risk Parity - Long Short
FeesPro_TFRPLS = FeesComputation(BpFees,NetWeightsRiskParity);
FeesIndividual_TFRPLS = FeesComputation(BpFeesIndividual,NetWeightsRiskParity);
Corrected_returns_TFRPLS_pro = ReturnTFRPLS - FeesPro_TFRPLS(4:end-1);
Corrected_returns_TFRPLS_individual = ReturnTFRPLS - FeesIndividual_TFRPLS(4:end-1);

% Risk Parity - Long Only
FeesPro_TFRPLO = FeesComputation(BpFees,NetWeightsRiskParityLO);
FeesIndividual_TFRPLO = FeesComputation(BpFeesIndividual,NetWeightsRiskParityLO);
Corrected_returns_TFRPLO_pro = ReturnTFRPLO - FeesPro_TFRPLO(4:end-1);
Corrected_returns_TFRPLO_individual = ReturnTFRPLO - FeesIndividual_TFRPLO(4:end-1);

% Computing Sharpe Ratios
Sharpe1 = SharpeRatio(Corrected_returns_TFVPLS_pro,0.01);
Sharpe2 = SharpeRatio(Corrected_returns_TFVPLS_individual,0.01);
Sharpe3 = SharpeRatio(Corrected_returns_TFRPLS_pro,0.01);
Sharpe4 = SharpeRatio(Corrected_returns_TFRPLS_individual,0.01);
Sharpe5 = SharpeRatio(Corrected_returns_TFVPLO_pro,0.01);
Sharpe6 = SharpeRatio(Corrected_returns_TFVPLO_individual,0.01);
Sharpe7 = SharpeRatio(Corrected_returns_TFRPLO_pro,0.01);
Sharpe8 = SharpeRatio(Corrected_returns_TFRPLO_individual,0.01);

%Table of results
Sharpe_Fees = array2table([table2array(StatsTFVPLS(6,'Var1')),Sharpe1,Sharpe2;...
    table2array(StatsTFVPLO(6,'Var1')),Sharpe5,Sharpe6;...
    table2array(StatsTFRPLS(6,'Var1')),Sharpe3,Sharpe4;...
    table2array(StatsTFRPLO(6,'Var1')),Sharpe7,Sharpe8],...
    'RowNames',{'Volatility Parity Long-Short','Volatility Parity Long-Only','Risk Parity Long-Short','Risk Parity Long-Only'},...
'VariableNames',{'Without Fees','Industry Fees','Individual Fees'});

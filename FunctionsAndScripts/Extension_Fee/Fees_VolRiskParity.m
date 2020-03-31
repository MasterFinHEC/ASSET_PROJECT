% VOLATILITY PARITY

%1. Computing the fees
Fees = FeesComputation(BpFees,WeightsVolParity);

%2. Computing the returns  

% Baltas Volatility 
CorrectedReturns = MonReturn-Fees(2:end,:);
ReturnTFLSVP_Fees = ReturnBaltas(LevVolPar,CorrectedReturns,Signal,WeightsVolParity);
CumReturnTFLSVP_Fees = cumprod((1+ReturnTFLSVP_Fees)).*100;

% RISK PARITY

%1. Computing the fees
Fees_RiskPar = FeesComputation(BpFees,WeightsRiskParity);

%2. Computing the returns  
CorrectedReturns_RiskPar = MonReturn-Fees_RiskPar(2:end,:);
ReturnTFLSRP_Fees = ReturnBaltasRiskPar(LevRiskPar,CorrectedReturns_RiskPar,WeightsRiskParity);
CumReturnTFLSRP_Fees = cumprod((1+ReturnTFLSRP_Fees)).*100;
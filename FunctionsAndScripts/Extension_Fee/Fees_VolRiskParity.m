% VOLATILITY PARITY

%1. Computing the fees
    Fees = FeesComputation(BpFees,WeightsVolParity);

%2. Computing the returns  

% Alexeev and Souane Volatiltiy
CorrectedReturns = MonReturn-Fees(2:end,:);
ReturnTFLS_Fees = ReturnStrategy(WeightsVolParity,leverage,CorrectedReturns,Signal);
cumReturnTFLS_Fees = cumprod((1+ReturnTFLS_Fees)).*100;

% Baltas Volatility 
ReturnTFLSB_Fees = ReturnBaltas(LeverageBaltasVolPar,CorrectedReturns,Signal,WeightsVolParity);
cumReturnTFLSB_Fees = cumprod((1+ReturnTFLSB_Fees)).*100;


% RISK PARITY

%1. Computing the fees
    Fees_RiskPar = FeesComputation(BpFees,RiskPar);

%2. Computing the returns  

% Alexeev and Souane Volatiltiy
CorrectedReturns_RiskPar = MonReturn-Fees_RiskPar(2:end,:);
ReturnTFLSRP_Fees = ReturnStrategyRiskPar(RiskPar,LeverageRiskPar,CorrectedReturns_RiskPar);
cumReturnTFLSRP_Fees = cumprod((1+ReturnTFLSRP_Fees)).*100;

% Baltas Volatility 
ReturnTFLSRPB_Fees = ReturnBaltasRiskPar(LeverageBaltasRiskPar,CorrectedReturns_RiskPar,RiskPar);
cumReturnTFLSRPB_Fees = cumprod((1+ReturnTFLSRPB_Fees)).*100;
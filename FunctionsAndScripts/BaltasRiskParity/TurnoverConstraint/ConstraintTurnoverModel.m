OptimalWeights_RiskPar_Constraint = RiskParityOpti_TurnoverConstraint(Signal,...
    WeightsVolParity,returns,targetVol,LengthSignal,LengthVol,LengthMonth,...
    MonReturn,TargetTurnover);

% a. Leverage Computations 
LeverageBaltasRiskPar_Constraint = LeverageBaltasRiskParity(returns,LengthSignal,LengthMonth,...
                            LengthVol,OptimalWeights_RiskPar_Constraint,targetVol);

% b. Computing the return of the strategy. 
ReturnBaltasStrategyRiskParity_Constraint = ReturnBaltasRiskPar(LeverageBaltasRiskPar_Constraint,...
    MonReturn,OptimalWeights_RiskPar_Constraint);

% c. Computing Cumulative Returns
CumReturnLSTFRiskParity_Constraint = cumprod((ReturnBaltasStrategyRiskParity_Constraint+1)).*100;

% d. Computing Fees
%1. Computing the fees
    Fees_RiskParity_Constrained = FeesComputation(BpFees,OptimalWeights_RiskPar_Constraint);
    SumFees_RiskParity_Constrained = sum(Fees_RiskParity_Constrained,2);
    
%2. Computing the returns
CorrectedReturns_RiskParity_Constrained = MonReturn-Fees_RiskPar(2:end,:);
ReturnConstrained_Fees = ReturnBaltasRiskPar(LeverageBaltasRiskPar_Constraint,...
    CorrectedReturns_RiskParity_Constrained,OptimalWeights_RiskPar_Constraint);
cumReturnConstrained_Fees = cumprod((1+ReturnConstrained_Fees)).*100;

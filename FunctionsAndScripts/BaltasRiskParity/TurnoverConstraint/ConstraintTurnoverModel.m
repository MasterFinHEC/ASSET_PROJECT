
%% Computing the optimal weights under a turnover constraint
OptimalWeights_RiskPar_Constraint = RiskParityOpti_TurnoverConstraint(Signal,...
    WeightsVolParity,returns,targetVol,LengthSignal,LengthVol,LengthMonth,...
    MonReturn,TargetTurnover);

% a. Leverage Computations 
LevRiskParCons = LeverageBaltasRiskParity(returns,LengthSignal,LengthMonth,...
                            LengthVol,OptimalWeights_RiskPar_Constraint,targetVol);

% b. Computing the return of the strategy. 
ReturnVolParCons = ReturnBaltasRiskPar(LevRiskParCons,...
    MonReturn,OptimalWeights_RiskPar_Constraint);

% c. Computing Cumulative Returns
CumReturnLSTFRP_Cons = cumprod((ReturnVolParCons+1)).*100;

% d. Computing Fees

%1. Computing the fees
    Fees_RiskParity_Constrained = FeesComputation(BpFees,OptimalWeights_RiskPar_Constraint);
    
%2. Computing the returns
CorrectedReturns_RiskParity_Constrained = MonReturn-Fees_RiskParity_Constrained(2:end,:);
ReturnConstrained_Fees = ReturnBaltasRiskPar(LevRiskParCons,...
    CorrectedReturns_RiskParity_Constrained,OptimalWeights_RiskPar_Constraint);
CumReturnTFLSRP_ConsFees = cumprod((1+ReturnConstrained_Fees)).*100;

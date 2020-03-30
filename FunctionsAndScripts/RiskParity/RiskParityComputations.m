%Finding the optimal weights through FminCon optimisation
RiskPar = RiskParityOpti(Signal,WeightsVolParity,returns,targetVol,...
                          LengthSignal,LengthVol,LengthMonth);

%Finding the leverage and the portfolio Volatility
[LeverageRiskPar,PortfolioVolRiskPar] = LeverageRiskParity(RiskPar,returns,...
                                                           targetVol,LengthSignal,...
                                                           LengthVol,LengthMonth); 

%Computing the return of the strategy 
ReturnRiskParity = ReturnStrategyRiskPar(RiskPar,LeverageRiskPar,MonReturn);

%Cumulative Return
CumuReturnRiskPar = cumprod(1+ReturnRiskParity).*100;

%Marginal Contribution to risk
[MarginRisk,MargConRiskScaledParity] = MCR(RiskPar,returns,PortfolioVolRiskPar,...
                                           LengthSignal,LengthVol,LengthMonth);
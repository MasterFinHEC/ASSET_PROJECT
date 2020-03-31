%Finding the optimal weights through FminCon optimisation
WeightsRiskParity = RiskParityOpti(Signal,WeightsVolParity,returns,targetVol,...
                          LengthSignal,LengthVol,LengthMonth);

%Finding the leverage and the portfolio Volatility
[LevRiskPar,PortfolioVolRiskPar] = LeverageRiskParity(WeightsRiskParity,returns,...
                                                           targetVol,LengthSignal,...
                                                           LengthVol,LengthMonth); 

% b. Computing the return of the strategy. 
ReturnBaltasStrategyRiskParity = ReturnBaltasRiskPar(LevRiskPar,MonReturn,WeightsRiskParity);

% Computing Cumulative Returns
CumReturnLSTFRP = cumprod((ReturnBaltasStrategyRiskParity+1)).*100;

%Marginal Contribution to risk
[MarginRiskRiskParity,MargConRiskScaledParity] = MCR(WeightsRiskParity,returns,PortfolioVolRiskPar,...
                                           LengthSignal,LengthVol,LengthMonth,Signal);
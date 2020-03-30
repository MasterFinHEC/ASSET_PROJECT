% The computations of the signals and the weights don't change, we just
% need to be careful with the indexes. 

% a. Leverage Computations -> We will create another functions since it
%    doesn't match well with the other. 

LeverageBaltasRiskPar = LeverageBaltasRiskParity(returns,LengthSignal,LengthMonth,...
                            LengthVol,RiskPar,targetVol);

% b. Computing the return of the strategy. 
ReturnBaltasStrategyRiskParity = ReturnBaltasRiskPar(LeverageBaltasRiskPar,MonReturn,RiskPar);

% Computing Cumulative Returns
CumReturnLSTFRiskParity = cumprod((ReturnBaltasStrategyRiskParity+1)).*100;
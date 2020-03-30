%Computing the Weights of the strategy
WeightsVolParity = VolParity(returns,firstData,LengthSignal,...
                             LengthVol,LengthMonth); %Used a function to compute the weights

% Computing the vector of signals
Signal = SignalComputing(returns,firstData,LengthSignal,LengthMonth); %Computing all the signals 

% Leverage and portfolio Volatility
[leverage,PortfolioVol] = Leverage(WeightsVolParity,returns,targetVol,...
                                   Signal,LengthSignal,LengthVol,LengthMonth); %Finding a vector of leverage, each period.

% Finding the returns of the strategy 
ReturnTFLS = ReturnStrategy(WeightsVolParity,leverage,MonReturn,Signal); %Finding the return of the entire strategy

%Cumulative Return
cumReturnTFLS = cumprod((ReturnTFLS+1)).*100; %Computing the cumulative return

%Computing the marginal contribution to risk
[MarginContribRisk,MarginConRiskScaled] = MCR(WeightsVolParity,returns,...
                                              PortfolioVol,LengthSignal,...
                                              LengthVol,LengthMonth);
                                          


%% Computing the volatility strategy weights and returns

% 1. Computing the Weights of the strategy
WeightsVolParity = VolParity(returns,firstData,LengthSignal,...
                             LengthVol,LengthMonth); %Used a function to compute the weights

%  2. Computing the vector of signals
Signal = SignalComputing(returns,firstData,LengthSignal,LengthMonth); %Computing all the signals 

% 3. Computing the leverage of the strategy
[LevVolPar,PortVol] = LeverageBaltas(returns,LengthSignal,LengthMonth,...
                            LengthVol,WeightsVolParity,Signal,targetVol);

% b. Computing the return of the strategy. 
ReturnBaltasStrategy = ReturnBaltas(LevVolPar,MonReturn,Signal,WeightsVolParity);

% Computing Cumulative Returns
CumReturnLSTFVP = cumprod((ReturnBaltasStrategy+1)).*100;

%Marginal Contribution to risk
[MarginRiskVolParity,MargConRiskScaled] = MCR(WeightsVolParity,returns,PortVol,...
                                           LengthSignal,LengthVol,LengthMonth,Signal);
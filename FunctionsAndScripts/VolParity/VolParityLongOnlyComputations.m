% Computing the volatility Parity Long Only Weighting scheme


% 1. Computing the leverage of the strategy

       %Creating a vector of signal with only ones
       SignalLongOnly = ones(size(Signal,1),size(Signal,2));
       LevVolParLongOnly = LeverageBaltas(returns,LengthSignal,LengthMonth,...
                            LengthVol,WeightsVolParity,SignalLongOnly,targetVol);


% 2. Finding the returns of the Long only Strategy
ReturnTFLO = ReturnStrategyLONGONLY(WeightsVolParity,LevVolParLongOnly,MonReturn);

% 3. Computing the cumulative returns
CumReturnTFLO = cumprod((ReturnTFLO+1)).*100; %Computing the cumulative return
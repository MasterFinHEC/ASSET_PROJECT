% Finding the returns of the Long only Strategy
ReturnTFLO = ReturnStrategyLONGONLY(WeightsVolParity,leverage,MonReturn);

% Computing the cumulative returns
cumReturnTFLO = cumprod((ReturnTFLO+1)).*100; %Computing the cumulative return
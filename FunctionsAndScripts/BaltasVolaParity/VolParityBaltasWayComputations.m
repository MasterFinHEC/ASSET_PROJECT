% The computations of the signals and the weights don't change, we just
% need to be careful with the indexes. 

% a. Leverage Computations -> We will create another functions since it
%    doesn't match well with the other. 

LeverageBaltasVolPar = LeverageBaltas(returns,LengthSignal,LengthMonth,...
                            LengthVol,WeightsVolParity,Signal,targetVol);

% b. Computing the return of the strategy. 
ReturnBaltasStrategy = ReturnBaltas(LeverageBaltasVolPar,MonReturn,Signal,WeightsVolParity);

% Computing Cumulative Returns
CumReturnLSTFB = cumprod((ReturnBaltasStrategy+1)).*100;

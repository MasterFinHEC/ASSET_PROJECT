%% Plot of the constrained Model Vs not constrained -> With and without Fees

f = figure('visible','off');
plot(monthdate(3:end),CumReturnLSTFRiskParity,...
    monthdate(3:end),cumReturnTFLSRPB_Fees,...
    monthdate(3:end),CumReturnLSTFRiskParity_Constraint,...
    monthdate(3:end),cumReturnConstrained_Fees)
title('Risk parity with and with turnover constraint')
legend('Not Constrained','Not Constrained with Fees','Constrained'...
    ,'Constrained with Fees','location','best')
print(f,'Output/ConstrainedPlots/StrategyCumuReturns_ConstrainedFees', '-dpng', '-r1000')
clear f

%% Plot the constrained model with fees and the vol parity with fees

f = figure('visible','off');
plot(monthdate(3:end),cumReturnTFLSB_Fees,'b',...
    monthdate(3:end),cumReturnConstrained_Fees,'r')
title('Volatility parity Vs. Risk Parity Constrained')
legend('Volatility Parity','Constrained Risk Parity','location','best')
print(f,'Output/ConstrainedPlots/StrategyCumuReturns_VolParityVSConstrainedRiskParity', '-dpng', '-r1000')
clear f
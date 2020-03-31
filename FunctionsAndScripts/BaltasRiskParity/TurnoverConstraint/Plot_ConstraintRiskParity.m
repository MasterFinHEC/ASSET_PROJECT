%% Plot of the constrained Model Vs not constrained -> With and without Fees

f = figure('visible','off');
plot(monthdate(3:end),CumReturnLSTFRP(4:end),...
    monthdate(3:end),CumReturnTFLSRP_Fees(4:end),...
    monthdate(3:end),CumReturnLSTFRP_Cons,...
    monthdate(3:end),CumReturnTFLSRP_ConsFees)
title('Risk parity with and without turnover constraint')
legend('Not Constrained','Not Constrained with Fees','Constrained'...
    ,'Constrained with Fees','location','best')
print(f,'Output/ConstrainedPlots/StrategyCumuReturns_ConstrainedFees', '-dpng', '-r1000')
clear f

%% Plot the constrained model with fees and the vol parity with fee
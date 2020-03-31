%% Plot of the extension with fees

%% Risk Parity with and without fees
f = figure('visible','off');
plot(monthdate,CumReturnTFLSRP_Fees(2:end),monthdate,CumReturnLSTFRP(2:end))
title('Performance of Risk Parity strategy with/without fees')
legend('With Fees','Without Fees','location','best')
print(f,'Output/FeesPlots/RiskParity_Fees', '-dpng', '-r1000')
clear f

%% Volatility Parity Vs. Risk Parity with/without Fees
f = figure('visible','off');
plot(monthdate(3:end),CumReturnTFLSVP_Fees,...
    monthdate(3:end),CumReturnLSTFVP,...
    monthdate(3:end),CumReturnTFLSRP_Fees(4:end),...
    monthdate(3:end),CumReturnLSTFRP(4:end))
title('Performance of strategy with/without fees')
legend('Vol. Parity with Fees','Vol. Parity without Fees',...
    'Risk Parity with Fees','Risk Parity without Fees','location','best')
print(f,'Output/FeesPlots/RiskParity_Vs_VolParity_Fees', '-dpng', '-r1000')
clear f

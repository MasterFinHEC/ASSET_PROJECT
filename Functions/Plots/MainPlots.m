%% Script Computing the Main Plots that are in the Paper (Baltas Way)

%% Volatility Parity - Long Short Vs Long Only

f = figure('visible','off');
plot(monthdate(3:end),CumReturnLSTFB,monthdate(3:end),cumReturnTFLO(3:end))
title('Long-Short VS. Long-Only Strategy')
legend('Long-Short','Long-Only','Location','Best')
xlabel('Years')
ylabel('Cumulative Returns (base = 100)')
print(f,'Output/MainPlots/VolParity_LO_VS_LS', '-dpng', '-r1000')
clear f

%% Volatility Parity - Long Short Vs Long Only - Post Crisis

f = figure('visible','off');
plot(monthdate(228:290),cumprod(ReturnBaltasStrategy(228:290)+1).*100,monthdate(228:290),cumprod(ReturnTFLO(228:290)+1).*100)
title('Long-Short VS. Long-Only Strategy - Post Crisis (2009-2013)')
legend('Long-Short','Long-Only','Location','Best')
xlabel('Years')
ylabel('Cumulative Returns (base = 100)')
print(f,'Output/MainPlots/VolParity_LO_VS_LS_PostCrisis', '-dpng', '-r1000')
clear f

%% Volatility Parity Vs. Risk Parity

f = figure('visible','off');
plot(monthdate(3:end),CumReturnLSTFRiskParity(4:end),monthdate(3:end),CumReturnLSTFB)
title('Volatility Parity vs Risk Parity Long-Short Strategy')
legend('Risk Parity','Volatility Parity','location','best')
print(f,'Output/MainPlots/Volatility_VS_Risk_LongShort', '-dpng', '-r1000')
clear f

%% Volatility Parity Vs. Risk Parity - Post Crisis

f = figure('visible','off');
plot(monthdate(228:290),CumReturnLSTFRiskParity(228:290),monthdate(228:290),CumReturnLSTFB(228:290))
title('Volatility Parity vs Risk Parity Long-Short Strategy - Post Crisis (2009-2013)')
legend('Risk Parity','Volatility Parity','location','best')
print(f,'Output/MainPlots/Volatility_VS_Risk_LongShort_PostCrisis', '-dpng', '-r1000')
clear f
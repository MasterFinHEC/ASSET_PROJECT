%% Script Computing the Main Plots that are in the Paper

%% Volatility Parity - Long Short Vs Long Only

f = figure('visible','off');
semilogy(monthdate(4:end),CumReturnTFVPLS,monthdate(4:end),CumReturnTFVPLO)
title('Long-Short VS. Long-Only Strategy')
legend('Long-Short','Long-Only','Location','Best')
xlabel('Years')
ylabel('Cumulative Returns (base = 100)')
print(f,'Output/MainPlots/VolParity_LO_VS_LS', '-dpng', '-r1000')
clear f

%% Volatility Parity - Long Short Vs Long Only - Post Crisis

f = figure('visible','off');
semilogy(monthdate(228:290),cumprod(ReturnTFVPLS(228:290)+1).*100,monthdate(228:290),cumprod(ReturnTFVPLO(228:290)+1).*100)
title('Long-Short VS. Long-Only Strategy - Post Crisis (2009-2013)')
legend('Long-Short','Long-Only','Location','Best')
xlabel('Years')
ylabel('Cumulative Returns (base = 100)')
print(f,'Output/MainPlots/VolParity_LO_VS_LS_PostCrisis', '-dpng', '-r1000')
clear f

%% Volatility Parity Vs. Risk Parity

f = figure('visible','off');
semilogy(monthdate(4:end),CumReturnTFRPLS,monthdate(4:end),CumReturnTFVPLS)
title('Volatility Parity vs Risk Parity Long-Short Strategy')
legend('Risk Parity','Volatility Parity','location','best')
print(f,'Output/MainPlots/Volatility_VS_Risk_LongShort', '-dpng', '-r1000')
clear f

%% Volatility Parity Vs. Risk Parity - Post Crisis

f = figure('visible','off');
semilogy(monthdate(228:290),cumprod(ReturnTFRPLS(228:290)+1).*100,monthdate(228:290),cumprod(ReturnTFVPLS(228:290)+1).*100)
title('Volatility Parity vs Risk Parity Long-Short Strategy - Post Crisis (2009-2013)')
legend('Risk Parity','Volatility Parity','location','best')
print(f,'Output/MainPlots/Volatility_VS_Risk_LongShort_PostCrisis', '-dpng', '-r1000')
clear f

%% Volatility Parity - Long ongly Vs Long Only RP VS VP

f = figure('visible','off');
semilogy(monthdate(4:end),CumReturnTFRPLO,monthdate(4:end),CumReturnTFVPLO)
title('Volatility Vs. Risk Parity Long Only Strategy')
legend('Risk Parity','Volatilty Parity','Location','Best')
xlabel('Years')
ylabel('Cumulative Returns (base = 100)')
print(f,'Output/MainPlots/VolParityLO_RPVSVP', '-dpng', '-r1000')
clear f

%% Volatility Parity Vs. Risk Parity - Post Crisis

f = figure('visible','off');
semilogy(monthdate(228:290),cumprod(ReturnTFRPLO(228:290)+1).*100,monthdate(228:290),cumprod(ReturnTFVPLO(228:290)+1).*100)
title('Long Only VP V. RP - Post Crisis (2009-2013)')
legend('Risk Parity','Volatility Parity','location','best')
print(f,'Output/MainPlots/Volatility_VS_Risk_LongONLY_PostCrisis', '-dpng', '-r1000')
clear f

%% Fees Risk VS Vol LS pro

f = figure('visible','off');
semilogy(monthdate(4:end),cumprod(Corrected_returns_TFVPLS_pro(:)+1).*100,monthdate(4:end),cumprod(ReturnTFVPLS(:)+1).*100, ...
    monthdate(4:end),cumprod(Corrected_returns_TFRPLS_pro(:)+1).*100,monthdate(4:end),cumprod(ReturnTFRPLS(:)+1).*100)
title('Volatility Vs. Risk Parity (Industry Fees)')
legend('Volatility Parity after fees','Volatility Parity','Risk Parity after fees','Risk Parity','location','best')
print(f,'Output/MainPlots/FEES_Volatility_VS_Risk_LongShort', '-dpng', '-r1000')
clear f

%% Fees Risk VS Vol LS individual

f = figure('visible','off');
semilogy(monthdate(4:end),cumprod(Corrected_returns_TFVPLS_individual(:)+1).*100,monthdate(4:end),cumprod(ReturnTFVPLS(:)+1).*100, ...
    monthdate(4:end),cumprod(Corrected_returns_TFRPLS_individual(:)+1).*100,monthdate(4:end),cumprod(ReturnTFRPLS(:)+1).*100)
title('Volatility Vs. Risk Parity (Individual Fees)')
legend('Volatility Parity after fees','Volatility Parity','Risk Parity after fees','Risk Parity','location','best')
print(f,'Output/MainPlots/FEES_Volatility_VS_Risk_LongShort_Individual', '-dpng', '-r1000')
clear f

%% ALL Industry Fees

f = figure('visible','off');
semilogy(monthdate(4:end),cumprod(Corrected_returns_TFVPLS_pro(:)+1).*100,monthdate(4:end),cumprod(Corrected_returns_TFVPLO_pro(:)+1).*100, ...
    monthdate(4:end),cumprod(Corrected_returns_TFRPLS_pro(:)+1).*100,monthdate(4:end),cumprod(Corrected_returns_TFRPLO_pro(:)+1).*100)
title('All model with fees')
legend('Volatility Parity Long-Short','Volatility Parity Long-Only','Risk Parity Long-Short','Risk Parity Long-Only','location','best')
print(f,'Output/MainPlots/FEES_All', '-dpng', '-r1000')
clear f


%% All Strat
f = figure('visible','off');
semilogy(monthdate(4:end),CumReturnTFRPLS,monthdate(4:end),CumReturnTFVPLS,monthdate(4:end),CumReturnTFRPLO,monthdate(4:end),CumReturnTFVPLO)
title('Volatility Parity Vs. Risk Parity Long-Short / Long-Only Strategies')
legend('Risk Parity LS','Volatility Parity LS','Risk Parity LO','Volatility Parity LO','location','best')
print(f,'Output/MainPlots/Allstrat', '-dpng', '-r1000')
clear f

%% Histogram of returns

f = figure('visible','off');
histogram(ReturnTFRPLS,'FaceAlpha',0.6)
hold on; 
histogram(B(4:end,1),'FaceAlpha',0.6)
title('Risk Parity and MSCI world Distribution of monthly returns')
legend('Risk Parity Long Short','MSCI World','location','best')
print(f,'Output/MainPlots/HistReturns', '-dpng', '-r1000')
clear f

f = figure('visible','on');
scatter(ReturnTFRPLS,B(4:end,1))
title('Risk Parity and MSCI world monthly returns')
print(f,'Output/MainPlots/ScatterReturns', '-dpng', '-r1000')
xlim([-0.1 0.1])
ylim([-0.1 0.1])
xlabel('Long-short Risk Parity')
ylabel('Msci World')
print(f,'Output/MainPlots/ScatterReturns', '-dpng', '-r1000')
clear f

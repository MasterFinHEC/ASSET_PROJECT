%% Plots Risk Parity Strategy

%% Plot of the return
f = figure('visible','off');
plot(monthdate,ReturnRiskParity)
title('Return of the Long-Short strategy')
xlabel('Years')
ylabel('Cumulative Returns (base = 100)')
print(f,'Output/Plot_RiskParity/StrategyReturns', '-dpng', '-r300')

%% Plot of cumulative return 
f = figure('visible','off');
plot(monthdate,CumuReturnRiskPar)
title('Long-Short VS. Long-Only Strategy')
print(f,'Output/Plot_RiskParity/StrategyCumuReturns', '-dpng', '-r300')

%% Plot of the Repartition of weights
GrossRiskPar = abs(RiskPar);
for i = 1:length(GrossRiskPar)
    total = sum(GrossRiskPar(i,:));
    GrossRiskPar(i,:) = GrossRiskPar(i,:)*100/total;
end

WeightsClassesRiskPar = zeros(length(RiskPar),5);

for i = 1:length(WeightsClassesRiskPar)
    WeightsClassesRiskPar(i,1) = sum(GrossRiskPar(i,1:7));
     WeightsClassesRiskPar(i,2) = sum(GrossRiskPar(i,8:11)) ;
      WeightsClassesRiskPar(i,3) = sum(GrossRiskPar(i,12:21)) ;
       WeightsClassesRiskPar(i,4) = sum(GrossRiskPar(i,22:28)) ;
        WeightsClassesRiskPar(i,5) = sum(GrossRiskPar(i,29:35)) ;
end


f = figure('visible','off');
area(monthdate, WeightsClassesRiskPar(2:end,:))
colormap winter
% Add a legend
%legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','South','Orientation','horizontal')
% Add title and axis labels
title('Repartition of weights through asset classes - Risk Par')
xlabel('Years')
ylabel('Weights')
ylim([0 100])
print(f,'Output/Plot_RiskParity/RepartitionOfWeights', '-dpng', '-r300')


%% Plot of the Repartition of MCR
MCRClasses = zeros(length(MargConRiskScaledParity),5);

for i = 1:length(MCRClasses)
    MCRClasses(i,1) = sum(MargConRiskScaledParity(i,1:7)) ;
     MCRClasses(i,2) = sum(MargConRiskScaledParity(i,8:11)) ;
      MCRClasses(i,3) = sum(MargConRiskScaledParity(i,12:21)) ;
       MCRClasses(i,4) = sum(MargConRiskScaledParity(i,22:28)) ;
        MCRClasses(i,5) = sum(MargConRiskScaledParity(i,29:35)) ;
end

f = figure('visible','off');
area(monthdate, MCRClasses(2:end,:))
colormap winter
% Add a legend
%legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','South','Orientation','horizontal')
% Add title and axis labels
title('Repartition of MCR through asset classes - Risk Parity')
xlabel('Years')
ylabel('Weights')
ylim([-10 110])
print(f,'Output/Plot_RiskParity/RepartitionOfMCR', '-dpng', '-r300')
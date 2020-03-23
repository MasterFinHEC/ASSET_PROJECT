%% Plots Volatility Strategy

%% Plot of the return
f = figure('visible','off');
plot(monthdate,Retour)
title('Return of the Long-Short strategy')
xlabel('Years')
ylabel('Cumulative Returns (base = 100)')
print(f,'Output/Plot_VolParity/StrategyReturns', '-dpng', '-r300')

%% Plot of cumulative return 
f = figure('visible','off');
plot(monthdate,cumReturn,'r',monthdate,cumReturnLO,'b')
title('Long-Short VS. Long-Only Strategy')
print(f,'Output/Plot_VolParity/StrategyCumuReturns', '-dpng', '-r300')

%% Plot of the Repartition of weights
WeightsClasses = zeros(length(WeightsVolParity),5);

for i = 1:length(WeightsClasses)
    WeightsClasses(i,1) = sum(WeightsVolParity(i,1:7)) ;
     WeightsClasses(i,2) = sum(WeightsVolParity(i,8:11)) ;
      WeightsClasses(i,3) = sum(WeightsVolParity(i,12:21)) ;
       WeightsClasses(i,4) = sum(WeightsVolParity(i,22:28)) ;
        WeightsClasses(i,5) = sum(WeightsVolParity(i,29:35)) ;
end

f = figure('visible','off');
area(monthdate, WeightsClasses(2:end,:))
colormap winter
title('Repartition of weights through asset classes')
xlabel('Years')
ylabel('Weights')
ylim([0 1])
print(f,'Output/Plot_VolParity/RepartitionWeights', '-dpng', '-r300')


%% Plot of the Repartition of MCR
MCRClasses = zeros(length(MarginConRiskScaled),5);

for i = 1:length(MCRClasses)
    MCRClasses(i,1) = sum(MarginConRiskScaled(i,1:7)) ;
     MCRClasses(i,2) = sum(MarginConRiskScaled(i,8:11)) ;
      MCRClasses(i,3) = sum(MarginConRiskScaled(i,12:21)) ;
       MCRClasses(i,4) = sum(MarginConRiskScaled(i,22:28)) ;
        MCRClasses(i,5) = sum(MarginConRiskScaled(i,29:35)) ;
end

f = figure('visible','off');
area(monthdate, MCRClasses(2:end,:))
colormap winter
% Add a legend
%legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','South','Orientation','horizontal')
% Add title and axis labels
title('Repartition of MCR through asset classes')
xlabel('Years')
ylabel('Weights')
ylim([-10 110])
print(f,'Output/Plot_VolParity/RepartitionMCR', '-dpng', '-r300')
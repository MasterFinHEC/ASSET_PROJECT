%% Plots Risk Parity Strategy

%Plot of the return
plot(monthdate(2:end),ReturnRiskParity)

%Plot of cumulative return 
plot(monthdate(2:end),CumuReturnRiskPar)

GrossRiskPar = abs(RiskPar);
for i = 1:length(GrossRiskPar)
    total = sum(GrossRiskPar(i,:));
    GrossRiskPar(i,:) = GrossRiskPar(i,:)*100/total;
end
%Plot of the Repartition of weights

WeightsClassesRiskPar = zeros(385,5);

for i = 1:385
    WeightsClassesRiskPar(i,1) = sum(GrossRiskPar(i,1:7)) ;
     WeightsClassesRiskPar(i,2) = sum(GrossRiskPar(i,8:11)) ;
      WeightsClassesRiskPar(i,3) = sum(GrossRiskPar(i,12:21)) ;
       WeightsClassesRiskPar(i,4) = sum(GrossRiskPar(i,22:28)) ;
        WeightsClassesRiskPar(i,5) = sum(GrossRiskPar(i,29:35)) ;
end

%Plot of the Repartition of weights
figure
area(monthdate, WeightsClassesRiskPar)
colormap winter
% Add a legend
%legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','South','Orientation','horizontal')
% Add title and axis labels
title('Repartition of weights through asset classes - Risk Par')
xlabel('Years')
ylabel('Weights')
ylim([0 100])

MCRClasses = zeros(385,5);

for i = 1:385
    MCRClasses(i,1) = sum(MarginRiskParity(i,1:7)) ;
     MCRClasses(i,2) = sum(MarginRiskParity(i,8:11)) ;
      MCRClasses(i,3) = sum(MarginRiskParity(i,12:21)) ;
       MCRClasses(i,4) = sum(MarginRiskParity(i,22:28)) ;
        MCRClasses(i,5) = sum(MarginRiskParity(i,29:35)) ;
end

%Plot of the Repartition of weights
figure
area(monthdate, MCRClasses)
colormap winter
% Add a legend
%legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','South','Orientation','horizontal')
% Add title and axis labels
title('Repartition of MCR through asset classes - Risk Parity')
xlabel('Years')
ylabel('Weights')
ylim([-10 110])
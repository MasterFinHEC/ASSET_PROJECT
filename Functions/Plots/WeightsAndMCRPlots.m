%% Plot of the Repartition of weights
WeightsClasses = zeros(length(GrossWeightsVolParity),5);

for i = 1:length(WeightsClasses)
    WeightsClasses(i,1) = sum(GrossWeightsVolParity(i,1:7)).*100 ;
     WeightsClasses(i,2) = sum(GrossWeightsVolParity(i,8:11)).*100 ;
      WeightsClasses(i,3) = sum(GrossWeightsVolParity(i,12:21)).*100 ;
       WeightsClasses(i,4) = sum(GrossWeightsVolParity(i,22:28)).*100 ;
        WeightsClasses(i,5) = sum(GrossWeightsVolParity(i,29:35)).*100 ;
end

f = figure('visible','off');
area(monthdate, WeightsClasses(2:end,:))
colormap winter
x0=10;
y0=10;
width=700;
height=400;
set(gcf,'position',[x0,y0,width,height])
legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
title('Repartition of weights through asset classes - Vol. Parity')
xlabel('Years')
ylabel('Weights')
ylim([0 100])
print(f,'Output/MCRPlots/VolatilityParityWeights', '-dpng', '-r1000')
clear f

%% Plot of the Repartition of MCR
MCRClasses = zeros(length(MCRVolParity),5);

for i = 1:length(MCRClasses)
    MCRClasses(i,1) = sum(MCRVolParity(i,1:7)) ;
     MCRClasses(i,2) = sum(MCRVolParity(i,8:11)) ;
      MCRClasses(i,3) = sum(MCRVolParity(i,12:21)) ;
       MCRClasses(i,4) = sum(MCRVolParity(i,22:28)) ;
        MCRClasses(i,5) = sum(MCRVolParity(i,29:35)) ;
end

f = figure('visible','off');
area(monthdate, MCRClasses(2:end,:))
colormap winter
x0=10;
y0=10;
width=700;
height=400;
set(gcf,'position',[x0,y0,width,height])
% Add a legend
legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
% Add title and axis labels
title('Repartition of MCR through asset classes - Vol. Parity')
xlabel('Years')
ylabel('Risk Allocation')
ylim([-10 110])
print(f,'Output/MCRPlots/VolatilityParityMCR', '-dpng', '-r1000')
clear f


%% Plot of the Repartition of weights

for i =1:length(NetWeightsRiskParity)
    GrossRiskPar(i,:) = abs(NetWeightsRiskParity(i,:))/sum(abs(NetWeightsRiskParity(i,:))).*100;
end

%GrossRiskPar = abs(NetWeightsRiskParity)./sum(abs(NetWeightsRiskParity)).*100;
WeightsClassesRiskPar = zeros(length(NetWeightsRiskParity),5);

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
x0=10;
y0=10;
width=700;
height=400;
set(gcf,'position',[x0,y0,width,height])
legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
% Add title and axis labels
title('Repartition of weights through asset classes - Risk Parity')
xlabel('Years')
ylabel('Weights')
ylim([0 100])
print(f,'Output/MCRPlots/RiskParityWeights', '-dpng', '-r301')
clear f GrossRiskPar

%% Plot of the Repartition of MCR
MCRClasses = zeros(length(MCRRiskParity),5);

for i = 1:length(MCRClasses)
    MCRClasses(i,1) = sum(MCRRiskParity(i,1:7)) ;
     MCRClasses(i,2) = sum(MCRRiskParity(i,8:11)) ;
      MCRClasses(i,3) = sum(MCRRiskParity(i,12:21)) ;
       MCRClasses(i,4) = sum(MCRRiskParity(i,22:28)) ;
        MCRClasses(i,5) = sum(MCRRiskParity(i,29:35)) ;
end

f = figure('visible','off');
area(monthdate, MCRClasses(2:end,:))
colormap winter
x0=10;
y0=10;
width=700;
height=400;
set(gcf,'position',[x0,y0,width,height])
% Add a legend
legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
% Add title and axis labels
title('Repartition of MCR through asset classes - Risk Parity')
xlabel('Years')
ylabel('Risk Allocation')
ylim([-10 110])
print(f,'Output/MCRPlots/RiskParityMCR', '-dpng', '-r300')
clear f

%% Plot of the Repartition of weights

GrossRiskPar = abs(NetWeightsRiskParityLO).*100;
WeightsClassesRiskPar = zeros(length(NetWeightsRiskParityLO),5);

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
x0=10;
y0=10;
width=700;
height=400;
set(gcf,'position',[x0,y0,width,height])
legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
% Add title and axis labels
title('Repartition of weights through asset classes - Risk Parity Long-Only')
xlabel('Years')
ylabel('Weights')
ylim([0 100])
print(f,'Output/MCRPlots/RiskParityLOWeights', '-dpng', '-r301')
clear f GrossRiskPar

%% Plot of the Repartition of MCR

MCRClasses = zeros(length(MCRRiskParityLO),5);

for i = 1:length(MCRClasses)
    MCRClasses(i,1) = sum(MCRRiskParityLO(i,1:7)) ;
     MCRClasses(i,2) = sum(MCRRiskParityLO(i,8:11)) ;
      MCRClasses(i,3) = sum(MCRRiskParityLO(i,12:21)) ;
       MCRClasses(i,4) = sum(MCRRiskParityLO(i,22:28)) ;
        MCRClasses(i,5) = sum(MCRRiskParityLO(i,29:35)) ;
end

f = figure('visible','off');
area(monthdate, MCRClasses(2:end,:))
colormap winter
x0=10;
y0=10;
width=700;
height=400;
set(gcf,'position',[x0,y0,width,height])
% Add a legend
legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
% Add title and axis labels
title('Repartition of MCR through asset classes - Risk Parity Long-Only')
xlabel('Years')
ylabel('Risk Allocation')
ylim([-10 110])
print(f,'Output/MCRPlots/RiskParityLO', '-dpng', '-r300')
clear f
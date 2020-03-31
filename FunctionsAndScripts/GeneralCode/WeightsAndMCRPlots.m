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
x0=10;
y0=10;
width=700;
height=400;
set(gcf,'position',[x0,y0,width,height])
legend('Energy', 'Fixed Income', 'Commodities', 'Equities', 'Currencies','Location','bestoutside','Orientation','horizontal')
title('Repartition of weights through asset classes - Vol. Parity')
xlabel('Years')
ylabel('Weights')
ylim([0 1])
print(f,'Output/MCRPlots/RepartitionWeights', '-dpng', '-r1000')
clear f

%% Plot of the Repartition of MCR
MCRClasses = zeros(length(MargConRiskScaled),5);

for i = 1:length(MCRClasses)
    MCRClasses(i,1) = sum(MargConRiskScaled(i,1:7)) ;
     MCRClasses(i,2) = sum(MargConRiskScaled(i,8:11)) ;
      MCRClasses(i,3) = sum(MargConRiskScaled(i,12:21)) ;
       MCRClasses(i,4) = sum(MargConRiskScaled(i,22:28)) ;
        MCRClasses(i,5) = sum(MargConRiskScaled(i,29:35)) ;
end

f = figure('visible','off');
area(monthdate, MCRClasses)
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
ylabel('Weights')
ylim([-10 110])
print(f,'Output/MCRPlots/RepartitionMCR', '-dpng', '-r1000')
clear f


%% Plot of the Repartition of weights

GrossRiskPar = abs(WeightsRiskParity);
for i = 1:length(GrossRiskPar)
    total = sum(GrossRiskPar(i,:));
    GrossRiskPar(i,:) = GrossRiskPar(i,:)*100/total;
end

WeightsClassesRiskPar = zeros(length(WeightsRiskParity),5);

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
print(f,'Output/MCRPlots/RepartitionOfWeights', '-dpng', '-r301')
clear f

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
area(monthdate, MCRClasses)
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
ylabel('Weights')
ylim([-10 110])
print(f,'Output/MCRPlots/RepartitionOfMCR', '-dpng', '-r300')
clear f

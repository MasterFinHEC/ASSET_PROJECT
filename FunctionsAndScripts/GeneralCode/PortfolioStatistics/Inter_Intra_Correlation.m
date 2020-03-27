%Class Construction 
Energy = returns(:,1:7);
FixedIncome = returns(:,8:11);
Commodities = returns(:,12:21);
Equity = returns(:,22:28);
Currency = returns(:,29:35);

% Rolling Window Interclass-pairwise Correlation
IntraCorr = zeros(length(returns)-89,5);
for i = 90:length(returns)
    index = Energy(i,:) ~= 0;
    a = i-89;
    value = Energy(i-89:i,index==1);
    IntraCorr(a,1) = mean(tril(corrcoef(value),-1),'all');
end 
IntraCorr(:,1) = abs(IntraCorr(:,1));
for i = 90:length(returns)
    index = FixedIncome(i,:) ~= 0;
    a = i-89;
    value = FixedIncome(i-89:i,index==1);
    IntraCorr(a,2) = mean(tril(corrcoef(value),-1),'all');
end 
IntraCorr(:,2) = abs(IntraCorr(:,2));
for i = 90:length(returns)
    index = Commodities(i,:) ~= 0;
    a = i-89;
    value = Commodities(i-89:i,index==1);
    IntraCorr(a,3) = mean(tril(corrcoef(value),-1),'all');
end 
IntraCorr(:,3) = abs(IntraCorr(:,3));
for i = 90:length(returns)
    index = Equity(i,:) ~= 0;
    a = i-89;
    value = Equity(i-89:i,index==1);
    IntraCorr(a,4) = mean(tril(corrcoef(value),-1),'all');
end 
IntraCorr(:,4) = abs(IntraCorr(:,4));
for i = 90:length(returns)
    index = Currency(i,:) ~= 0;
    a = i-89;
    value = Currency(i-89:i,index==1);
    IntraCorr(a,5) = mean(tril(corrcoef(value),-1),'all');
end  
IntraCorr(:,5) = abs(IntraCorr(:,5));
ind = find(isnan(IntraCorr));
IntraCorr(ind) = arrayfun(@(x) nanmean(IntraCorr(x-5:x-1)), ind);

% Rolling Window InterclassClass Pairwise Correlation
EnergyIntra = mean(Energy,2);
FixedIncomeIntra = mean(FixedIncome,2);
CommoditiesIntra = mean(Commodities,2);
EquityIntra = mean(Equity,2);
CurrencyIntra = mean(Currency,2);
InterCorr = [EnergyIntra, FixedIncomeIntra, CommoditiesIntra, EquityIntra, CurrencyIntra];


InterCorrAll = zeros(7855,1);
for i = 90:length(returns)
    index = InterCorr(i,:) ~= 0;
    a = i-89;
    value = InterCorr(i-89:i,index==1);
    InterCorrAll(a,1) = abs(mean(tril(corrcoef(value),-1),'all'));
end

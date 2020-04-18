function[SharpeMeanEvent,Sharpe,Count] = CorrelationEvent(LengthSignal,LengthMonth,InterCorrAll,ReturnTFLS,RiskFreeRate)
%Computing the monthly points of autocorrelation

InterCorrMonthly = zeros();
position = 1;

for i = LengthSignal:LengthMonth:length(InterCorrAll)
    InterCorrMonthly(position,1) = InterCorrAll(i);
    position = position+1;
end

%Setting up Value
IndexCorr = zeros(1000,4); %Pre-allocating without knowing the size
Count = zeros(1,4);
  PositionLow = 1;
  PositionMiddle = 1;
  PositionHigh = 1;
  PositionExtreme = 1;
 
  %Loop attributing the value to each category
for i = 1:length(InterCorrMonthly)
    
    if InterCorrMonthly(i) <= 0.03
        
        IndexCorr(PositionLow,1) = i;
        Count(1,1) = Count(1,1) + 1;
        PositionLow = PositionLow + 1;
        
    elseif InterCorrMonthly(i) <= 0.07
        
        IndexCorr(PositionMiddle,2) = i;
        Count(1,2) = Count(1,2) + 1;
        PositionMiddle = PositionMiddle + 1;
        
    elseif InterCorrMonthly(i) <= 0.2
        
        IndexCorr(PositionHigh,3) = i;
        Count(1,3) = Count(1,3) + 1;
        PositionHigh = PositionHigh + 1;
        
    else 
        
        IndexCorr(PositionExtreme,4) = i;
        Count(1,4) = Count(1,4) + 1;
        PositionExtreme = PositionExtreme + 1;
        
    end
    
end 

% Computing Sharpe ratio for the indey
Sharpe = zeros(1000,4);

for i = 1:4
    N = find(IndexCorr(:,i)==0,1);
    for j = 1:N-1
    Sharpe(j,i) = (((ReturnTFLS(IndexCorr(j,i))+1)^12-1)-RiskFreeRate)/ ...
        (std(ReturnTFLS(1:IndexCorr(j,i)))*sqrt(12));
    end
end

SharpeMeanEvent = zeros(1,4);
for i = 1:4
    if i == 1
    N = find(IndexCorr(:,i)==0,1);
 SharpeMeanEvent(1,i) = mean(Sharpe(2:N,i));
    else
         N = find(IndexCorr(:,i)==0,1);
 SharpeMeanEvent(1,i) = mean(Sharpe(1:N,i));
    end
end

end
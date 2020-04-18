function [CumulativeReturns,Return] = StrategyReturn(Leverage,NetWeights,Returns)
% Function computing the retursn of a strategy

%Pre-allocating for speed
Return = zeros(length(Leverage)-1,1);

%Computing the returns
for i = 1:length(Leverage)-1
    Return(i) = Leverage(i)*NetWeights(i+3,:)*Returns(i+3,:)';
end

%Computing the cumulative returns
CumulativeReturns = cumprod(1+Return).*100;
end


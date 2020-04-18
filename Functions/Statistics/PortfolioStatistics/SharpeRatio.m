function [Sharpe] = SharpeRatio(Return,RiskFree)
%Function that computes the Sharpe Ratio of the strategy (Monthly Returns)
Sharpe = (prod(Return+1)^(1/(length(Return)/12)) - 1 - RiskFree)/(std(Return));
end


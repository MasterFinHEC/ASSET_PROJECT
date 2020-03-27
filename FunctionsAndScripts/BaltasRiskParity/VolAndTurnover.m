function [c,ceq] = VolAndTurnover(x,Target,CovMat,TargetTurnover,Returns)
%Volatility Constraint

[AverageTurnover,~] = turnover(Returns, x);

% Setting the non-linear inequality (volatility) constraint
c(1) = sqrt(x*CovMat*x') - Target;
c(2) = AverageTurnover - TargetTurnover;
c = [c(1) c(2)];

% Setting the unused equality constraint
ceq = [];

end


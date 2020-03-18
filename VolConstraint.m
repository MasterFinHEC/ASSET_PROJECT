function [c,ceq] = VolConstraint(x,Target,CovMat)
%Volatility Constraint

% Setting the non-linear inequality (volatility) constraint
c = sqrt(x*CovMat*x') - Target;

% Setting the unused equality constraint
ceq = [];
end


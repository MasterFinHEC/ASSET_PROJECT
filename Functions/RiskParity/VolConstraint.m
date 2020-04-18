function [c,ceq] = VolConstraint(x,Target,CovMat)
%Volatility Constraint

% Setting the non-linear inequality (volatility) constraint
c = sqrt(252)*sqrt(x*CovMat*x') - Target;

ceq = [];

end



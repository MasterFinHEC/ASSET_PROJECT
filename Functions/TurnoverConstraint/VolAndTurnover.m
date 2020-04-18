function [c,ceq] = VolAndTurnover(x,Target,CovMat,TargetTurnover,Returns,position,PreviousWeights)

%Volatility Constraint
c(1) = sqrt(x*CovMat*x') - Target;

%Constraint on turnover
T = size(x,2);
turnover = 0;
  for t=1:T
       sum = abs(x(t)-(1+Returns(position,t))*PreviousWeights(t)/(Returns(position,:)*x'+1));
       turnover = turnover+sum;
  end
  
  c(2) = turnover - TargetTurnover;
  

% Setting the non-linear inequality constraints
c = [c(1) c(2)];

% Setting the equality Constraint

ceq = [];

end


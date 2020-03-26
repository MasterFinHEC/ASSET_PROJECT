function [Strat] = ReturnBaltasRiskPar(Leverage,Returns,Weights)
%UNTITLED Summary of this function goes here

NetWeights = Weights;
% Pre allocating for speed
Strat = zeros(length(Leverage),1);

for a = 1:length(Leverage)-1
    
    Strat(a) = Leverage(a)*NetWeights(a+3,:)*Returns(a+3,:)';
end 
end


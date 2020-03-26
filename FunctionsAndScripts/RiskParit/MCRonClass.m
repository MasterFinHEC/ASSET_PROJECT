function [MargConRisk,MargConRiskScaled] = MCRonClass(Weights,Returns,PortfolioVol,LengthSignal,LengthVol,LengthMonth)
%MCR Computes the marginal contribution to risk of an asset

%   INPUT: 
% Weights : Matrix of weights 
% Returns : Matrix of returns
% PortfolioVol: Vector of volatility

%   OUTPUT:
% MargConRisk : Matrix of marginal contribution to risk

%Setting Parameters
asset = size(Returns,2);
position = 1;

%Pre-allocating the size of the output
MargConRisk = zeros(length(Weights),asset);
MargConRiskScaled = zeros(length(Weights),asset);

%Loop computing the leverage at each month
for i = 3:length(Weights)-1
    
    %Absolute value of weights
    Weights = abs(Weights);
    
    %Index of available assets at time i
    index = Weights(position,:)~=0;
    
    %Var/Covar matrix of available assets
    matrix = cov(Returns(i-2:i,index==1));
    
    %Available assets -> index of the available assets (to store in the
    %right place of the matrix)
    indexAvailable = find(index == 1);

   
    %Loop computing the MCR of each available asset for the time i
    for j = 1:length(indexAvailable)
       
        count = sum(Weights(position,indexAvailable(:)).*matrix(j,:))- ...
                    Weights(position,indexAvailable(j))*matrix(j,j);
        
        up = Weights(position,indexAvailable(j))*matrix(j,j) + count; %Intermediate Variable 
        MargConRisk(position,indexAvailable(j)) = up/PortfolioVol(position);  %Formula
        MargConRiskScaled(position,indexAvailable(j)) = MargConRisk(position,indexAvailable(j)) ...
                                                        *Weights(position,indexAvailable(j))/PortfolioVol(position);
    end
   
  
   MargConRiskScaled(position,:) = MargConRiskScaled(position,:).*100./sum(MargConRiskScaled(position,:));
    %Going over the next rebalancing
    position = position + 1;

end 
end


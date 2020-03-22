function [MargConRisk] = MCR(Weights,Returns,PortfolioVol,LengthSignal,LengthVol,LengthMonth)
%MCR Computes the marginal contribution to risk of an asset

%   INPUT: 
% Weights : Matrix of weights 
% Returns : Matrix of returns
% PortfolioVol: Vector of volatility

%   OUTPUT:
% MargConRisk : Matrix of marginal contribution to risk

asset = size(Returns,2);
position = 1;
MargConRisk = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0),asset);

%Loop computing the leverage at each month
for i = LengthSignal+1:LengthMonth:length(Returns)
    
%Index of available assets at time i
    index = Weights(position,:)~=0;
    
    %Var/Covar matrix of available assets
    matrix = cov(Returns(i-LengthVol+1:i,index==1));
    
    %Available assets -> index of the available assets (to store in the
    %right place of the matrix)
    indexAvailable = find(index == 1);

   
        %Loop computing the MCR of each available asset for the time i
    for j = 1:length(indexAvailable)
       
        count = sum(Weights(position,indexAvailable(:)).*matrix(j,:))-Weights(position,indexAvailable(j))*matrix(j,j);
        
        up = (Weights(position,indexAvailable(j))^2)*matrix(j,j) + count; %Intermediate Variable 
        MargConRisk(position,indexAvailable(j)) = up/PortfolioVol(position);  %Formula
    
    end
    
    %total = sum(MargConRisk(position,:));
    %MargConRisk(position,:) =  MargConRisk(position,:)*100/total;
    
    position = position + 1;

end 
end


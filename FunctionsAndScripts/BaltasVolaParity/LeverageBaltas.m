function [Leverage] = LeverageBaltas(Returns,LengthSignal,LengthMonth,LengthVol,Weights,Signal,targetVol)
%This function compute the running volatility of a portolio using the
%previous weights and volatility for LengthVol Days

%   INPUT : 



%   OUTPUT : 
%Leverage : A vector with the leverage for each rebalancing of the strat.

% Pre-Allocation the size of the output
NumberofRebalancing = round((length(Returns)-LengthSignal-LengthVol)/LengthMonth,0);
Leverage = zeros(NumberofRebalancing,1);

% Computing the NetWeights
NetWeights = Weights.*Signal;

% Setting up a positon index
position = 1; 

%% Loop Computing the leverages
 %Going from LengthSignal + Length Vol to the end
 
for i = (LengthSignal)+1:LengthMonth:length(Returns)-LengthVol
    
    %Pre-allocating a matrix of returns 
    WeightedReturns = zeros(LengthVol,1);
    
    %Creating the matrix of returns 
    index = Weights(position+3,:)~=0;
    indexAvailable = find(index==1);
    
    for j = 1:round(LengthVol/LengthMonth,0) % Typically = 3 for vol 63, month 21
        for k = 1:sum(index)
        WeightedReturns((j-1)*LengthMonth+1:(j-1)*LengthMonth+LengthMonth,indexAvailable(k)) ...
            = NetWeights(position,indexAvailable(k))*Returns(i+(j-1)*LengthMonth:...
            i+(j-1)*LengthMonth+LengthMonth-1,indexAvailable(k));
        end
    end
    
    %Computing the volatility of the matrix
    Vola = sqrt(252)*std(sum(WeightedReturns,2));
    
    %Finding the leverage
    Leverage(position) = targetVol/Vola;
    
    position = position + 1;
end 

% Computing the matrix of variance/covariance for the available assets

end


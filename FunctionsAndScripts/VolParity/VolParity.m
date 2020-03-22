function [weights] = VolParity(Returns,firstData,LengthSignal,LengthVol,LengthMonth)
%This function compute the weights of the Trend following strategy under a 
%volatility parity weighting scheme

%INPUT
% firstData : A vector with the index of the first available data
% FinancialReturns : A time series of financial price

%************************
%OUPUT
% Weights : A matrix of weights for each futur (each month)

% Setting parameters 
asset = size(Returns,2); %Vector setting the number of asset classes at our disposal


%Implementing the strategy
weights = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0),asset); %Matrice to store the Weights
position = 1; %Setting a position value

%Computing the weights for each month
    for i = LengthSignal+1:LengthMonth:length(Returns) %Start of the strategy, every month, until the end
    

        %Vector of available assets at time t
        available = firstData<=i-LengthSignal;
                
                IndexAvailable = find(available==1); %Vector of position of the available assets
                vola = zeros(1,length(IndexAvailable)); %Empty matrix storing the available vol
                
            for z = 1:length(IndexAvailable)
                    vola(z)= std(Returns(i-LengthVol+1:i,IndexAvailable(z))); %Volatility of each available assets
            end 
               
            invola=vola.^-1; %Inverting the volatility
        sumvola = sum(invola); %Sum of inverse vol.
                
      %Computing the Gross weights for the available assets
        for j = 1:length(IndexAvailable) %Loop Going over the number of available assets

            weights(position,IndexAvailable(j)) = (vola(j).^-1)/(sumvola); %Computing the Weights
  
        end
        
   position = position + 1; %Increasing the position to go over the next month
   
    end 

end


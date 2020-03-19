function [weights] = VolParity(Returns,firstData)
%This function compute the weights of the Trend following strategy under a 
%volatility parity weighting scheme

%INPUT
% firstData : A vector with the index of the first available data
% FinancialReturns : A time series of financial price

%************************
%OUPUT
% Weights : A matrix of weights for each futur (For all the month)

% Setting parameters out of the financial returns 
asset = size(Returns,2); %Vector setting the number of asset classes at our disposal


%Implementing the strategy
weights = zeros(round((length(Returns)-252)/20,0),asset); %Matrice to store the Weights
position = 1; %Setting a position value


%Computing the weights for each month

    for i = 253:20:length(Returns) %Start of the strategy, every month, until the end
    
    available = zeros(1,asset); % Empty matrix storing the index of available assets
    
        for k = 1:asset
            
            if i-252 < firstData(k)
                available(k) = 1;
            else 
                available(k) = 0;
            end
   
        end 
                
                IndexAvailable = find(available==0); %Vector of available Index
                vola = zeros(1,length(IndexAvailable)); %Empty matrix storing the available vol
                
            for z = 1:length(IndexAvailable)
                    vola(z)= std(Returns(i-90:i,IndexAvailable(z))); %Volatility of each available assets
            end 
               
            invola=vola.^-1; %Inverting the volatility
        sumvola = sum(invola); %Sum of inverse vol.
                
      %Computing the Gross weights for the available assets
        for j = 1:length(IndexAvailable) %Loop Going over the number of available assets

            weights(position,IndexAvailable(j)) = (vola(j).^-1)/(sumvola); %Computing the Weights
  
        end
      
        %Rescaling Weights
        SumWeights = 0; 
        
        %Loop adding the existing weights
        for x = 1:asset
            if weights(position,x) ~= 0
                SumWeights = SumWeights + weights(position,x);
            end 
        end 
       
        %Finding the weights in %
        weights(position,:) = weights(position,:)/SumWeights;
        
   position = position + 1; %Increasing the position to go over the next month
   
    end 

end


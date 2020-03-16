function [Weights] = TrendFollowVolParity(TargetVol,Prices)
%This function compute the weights of the Trend following strategy under a 
%volatility parity weighting scheme

%INPUT
% TargetVol : The targeted Volatility of the Strategy
% FinancialReturns : A time series of financial price

%************************
%OUPUT
% Weights : A matrix of weights for each asset class each futur
% Returns : A vector of monthly returns
% Sharpe : The Sharpe Ratio of the strategy
% Turn : The Turnover of the strategy

%Returns,Sharpe,Turn
% Setting parameters out of the financial returns 
N = length(Prices); %Vector setting the duration of the strategy
asset = size(Prices,2); %Vector setting the number of asset classes at our disposal

%Find the first non NAN Value
firstData = zeros(1,asset);
for i = 1:asset
firstData(1,i) = find (~ isnan (Prices(:,i)), 1);
end

% Computing Daily returns 
SimpleReturn = zeros(1,asset);
for i = 1:asset
SimpleReturn = Prices(2:end,firstData(i+1):end)./Prices(1:end-1,firstData(i,end-1)) + 1;
end

% Computing the initial signal of the strategy 
iniSignal = zeros(1,asset);
for i = 1:asset
   iniSignal(i) = prod(SimpleReturn(1:252,i));
   
     if iniSignal(i) > 0
         
       iniSignal(i) = 1;
       
     else
            
       iniSignal(1) = -1;
    end
end 


% Computing the initial (90 days) volatility to set up the Weights 
VolIni = std(SimpleReturn(252-90:252,:));
TotalVolIni = sum(VolIni); 

%Computing the inital (theoric) weights
WgrossIni = zeros(1,asset);
for i = 1:asset
    
    WgrossIni(i) = (VolIni(i).^-1)/TotalVolIni.^-1;
    
end 

%Computing the running volatltiy after 60 days and Leveraging the position
IniRisk = sqrt(var(WgrossIni*SimpleReturn(253:253+59,:).')); 
leverageIni = TargetVol/IniRisk;


%Implementing the strategy
weights = zeros((length(FinancialReturns)-312)/20,asset); %Matrice to store the Weights
position = 1; %Setting a position value


%Computing the weights for each month

for i = 312:20:length(Prices) %Start of the strategy, every month, until the end
    
    available = zeros(1,asset); % Empty matrix storing the index of available assets
    
        for k = 1:asset
            
      available(k) = isnan(price(i-252,k)) ; %Vector of 1 if Nan and 0 otherwise
   
        end 
                
                IndexAvailable = find(available==0); %Vector of available Index
                vola = zeros(1,length(IndexAvailable)); %Empty matrix storing the available vol
                
                for z = 1:length(IndexAvailable)
                    vola(z)= std(SimpleReturn(i-90:i,IndexAvailable(z))); %Volatility of each available assets
                end 
               
                sumvola = sum(vola); %Sum of vol.
                
      %Computing the Gross weights for the available assets
        for j = length(IndexAvailable) %Loop Going over the number of available assets

    weights(position,IndexAvailable(j)) = (vola(IndexAvailable(j)).^-1)/((sumvola).^-1); %Computing the Weights
  
        end
   position = position + 1; %Increasing the position to go over the next month
end 

Weights = weights;



end


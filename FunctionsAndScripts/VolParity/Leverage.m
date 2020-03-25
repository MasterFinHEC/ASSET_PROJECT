function [Leverage,VolPortfolio] = Leverage(Weights,Returns,TargetVol,Signal,LengthSignal,LengthVol,LengthMonth)
%Leverage Compute the risk of the portfolio and Leverage to took
%   Detailed explanation goes here

% INPUT : 
% Weights : A matrix of weights allowing us to compute the vol
% Returns : A matrix of returns allowing to compute the vol
% TargetVol : The target volatilty of the position

% OUTPUT : 
% Leverage : A vector of leverage for each month

% Matrix to store the leverage 
Leverage = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0),1);
VolPortfolio = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0),1);
position = 1;

% Computing Net Weights 
Weights = Weights.*Signal;

% Loop computing the leverage at each month
for i = LengthSignal+1:LengthMonth:length(Returns)
    
    % Index of available assets at time i
    index = Weights(position,:)~=0;
    
    % Var/Covar matrix of available assets
    matrix = cov(Returns(i-LengthVol+1:i,index==1));
    
    % Finding the risk of portfolio
    VolPort =  sqrt(Weights(position,index==1)*252*matrix*Weights(position,index==1)');
    
    % Computing the leverage
    Leverage(position) = TargetVol/VolPort; 
    
    % Having the Portfolio Vol in a vector
    VolPortfolio(position) = VolPort;
    
    % Going to the next rebalancing (i+MonthDate)
position = position + 1;  

end 

end


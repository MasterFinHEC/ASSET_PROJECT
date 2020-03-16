function [Leverage] = Leverage(Weights,Returns,TargetVol)
%Leverage Compute the risk of the portfolio and Leverage to took
%   Detailed explanation goes here

% INPUT : 
% Weights : A matrix of weights allowing us to compute the vol
% Returns : A matrix of returns allowing to compute the vol
% TargetVol : The target volatilty of the position

% OUTPUT : 
%Leverage : A vector of leverage for each month

%Matrix to store the leverage 
Leverage = zeros(round((length(Returns)-252)/20,0),1);
position = 1;

%Loop computing the leverage at each month
for i = 253:20:length(Returns)
    
    %Index of availavle assets at time i
    index = Weights(position,:)~=0;
    
    %Var/Covar matrix of available assets
    matrix = cov(Returns(i-60:i,index==1));
    
    %finding the risk of portfolio
    varPort =  Weights(position,index==1)*matrix*Weights(position,index==1)';
    VolPort = sqrt(varPort)*100;
    
    % Computing the leverage
    Leverage(position) = TargetVol/VolPort; 
    
    
position = position + 1;  

end 

end


function [strat] = ReturnStrategyRiskPar(Weights,Leverage,Returns)
%Compute the return of the strategy given all parameters 

% INPUT: 
% Weights : Net weights of the strategy 
% Leverage : Leverage taken each time
% Returns : Monthly Returns of the data

% OUTPUT:
% The return of the strategy (vector of return)

strat= zeros(length(Weights)-1,1);

    for i = 1:length(Weights)-1
        
        index = Weights(i,:)~=0; % Finding the Available assets'
        
        netweight = Weights(i,index==1); % Computing the net weights
        
        strat(i) = Leverage(i)*netweight*Returns(i,index==1)'; % Computing the return of the strat'
        
    end 
end



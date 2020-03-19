function [strat] = ReturnStrategy(Weights,Leverage,Returns,Signal)
%Compute the return of the strategy given all parameters 

% INPUT: 
% Weights : Weights of the strategy 
% Leverage : Leverage taken each time
% Returns : Monthly Returns of the strategy
% Signal : A matrix of Signal 

% OUTPUT:
% The return of the strategy (vector of return)

strat= zeros(length(Weights)-1,1);

    for i = 1:length(Weights)-1
        
        index = Weights(i,:)~=0; % Finding the Available assets'
        
        netweight = Weights(i,index==1).*Signal(i,index==1); % Computing the net weights
        
        strat(i) = Leverage(i)*netweight*Returns(i,index==1)'; % Computing the return of the strat'
        
    end 
end


function [strat] = ReturnStrategyLONGONLY(Weights,Leverage,Returns)
%Compute the return of the strategy given all parameters 

% INPUT: 
% Weights : Weights of the strategy 
% Leverage : Leverage taken each time
% Returns : Monthly Returns of the dataset
% Signal : A matrix of Signal 

% OUTPUT:
% The return of the strategy (vector of return)

%Defining the size of the output
strat= zeros(length(Leverage),1); %The size is based on the size of the input

    for i = 1:length(Leverage)-1
        
        index = Weights(i,:)~=0; % Finding the Available assets'
        
        strat(i) = Leverage(i,1)*Weights(i,index==1)*Returns(i,index==1)'; % Computing the return of the strat'
        
    end 
end


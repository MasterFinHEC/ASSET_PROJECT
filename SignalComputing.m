function [Signal] = SignalComputing(Returns,firstData)
%SignalComputing computes the signal (i.e twelve last month returns)
%   INPUT:
% Returns : Vector of Daily Returns
% firstData : A vector with the index of the first available data

%*******************************

%   OUTPUT:
% Signal : Matrix of signal (-1,1) for each asset when it is available, 0
% if the asset is not available. 

% Setting the parameters 
asset = size(Returns,2);


% Matrix to store the signal 
Signal = zeros(round((length(Returns)-252)/20,0),asset);

% Adding +1 to every return to compute yearly returns
Returns = Returns + 1;

% Loop computing the signal
% The loop is computing the signal for each asset and every month. 
position = 1; 

for i = 1:asset %For each asset 
    
    for j = 253:20:length(Returns) %Loop going over each portfolio rebalancing
        
        if j-252 >= firstData(i) %If the asset is available and has been for more than a year.
            
             Signal(position,i) = prod(Returns(j-252:j-1,i))-1; %Computing the return of asset i between
                                                                %time j-252 and j.
    
            if Signal(position,i) > 0 %condition for the yearly return
         
                 Signal(position,i) = 1; %If positive go long
       
            else
            
                 Signal(position,i) = -1; %If negative or zero go short 
            end
            
        else
            Signal(position,i) = 0; %Else do nothing (i.e the asset is not available)
        end
        position = position + 1;%Increase the position index (new month = Rebalancing)
    end
    position = 1; %Setting the position to one for the new asset
end 

end


function [Returns,firstData] = ReturnNaN(Prices)
%Function Computing the returns with a vector of price of heterogenic
%weights.
%   INPUT:
% Vector of prices

%*************************************

%   OUTPUT:
% Vector of returns

%Setting the parameters 
asset = size(Prices,2);

%Find the first non NAN Value
firstData = zeros(1,asset); %Vector having each first available prices

    for i = 1:asset
        firstData(1,i) = find (~ isnan (Prices(:,i)), 1);
    end

% Computing Daily returns 
Returns = zeros(length(Prices)-1,asset);

    for i = 1:asset
        
        for j = firstData(i):(length(Prices)-1)
            
        Returns(j,i) = Prices(j+1,i)/Prices(j,i)-1;
        
        end
        
    end
    
end


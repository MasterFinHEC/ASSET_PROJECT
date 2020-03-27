function [MaxDD] = MDD(Returns)
%MDD: function that computes the maximum drawdown from a vector/matrix of
%simple returns.
% INPUT:
%       - Returns
% OUTPUT:
%       - Maximum Drawdown
%--------------------------------------------------------------------------
[TR,NR] = size(Returns);
Price = ones(TR+1,NR); 
Price(2:end,:) = cumprod(1+Returns); %transform returns into price

[TP, NP] = size(Price);
MaxDD = zeros(1,NP);

	MaxData = Price(1,:);
    for i = 1:TP
		MaxData = max(MaxData, Price(i,:));
		q = MaxData == Price(i,:);
		DD = (MaxData - Price(i,:)) ./ MaxData;
		if any(DD > MaxDD)
			p = DD > MaxDD;
			MaxDD(p) = DD(p);
		end
    end
    
end
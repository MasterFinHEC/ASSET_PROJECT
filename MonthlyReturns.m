function [MonthReturn] = MonthlyReturns(Returns)
% Monthly Returns
%   Function Computing monthly returns. 

%Setting up parameters
Returns = Returns + 1; %To aggregate returns
asset = size(Returns,2); %Helping generalized the function

%Computing monthly returns
MonthReturn = zeros(round((length(Returns)-252)/20,0)-1,asset);
position = 1;

for i = 253:20:(length(Returns)-19)
    for j = 1:asset
    MonthReturn(position,j) = prod(Returns(i:i+19,j))-1;
    end
    position = position + 1;
end

end


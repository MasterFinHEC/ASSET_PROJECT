function [MonthReturn] = MonthlyReturns(Returns,LengthSignal,LengthMonth)
% Monthly Returns
%   Function Computing monthly returns. 

%Setting up parameters
Returns = Returns + 1; %To aggregate returns
asset = size(Returns,2); %Helping generalized the function

%Computing monthly returns
MonthReturn = zeros(round((length(Returns)-LengthSignal)/LengthMonth,0)-1,asset);
position = 1;

for i = LengthSignal+1:LengthMonth:(length(Returns)-LengthMonth)
    for j = 1:asset
    MonthReturn(position,j) = prod(Returns(i:i+LengthMonth-1,j))-1;
    end
    position = position + 1;
end

end


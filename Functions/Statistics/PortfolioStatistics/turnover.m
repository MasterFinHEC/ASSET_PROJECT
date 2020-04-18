function [AverageTurnover,Turnover] = turnover(Returns, Weights)
% Function Computing the turnover of a strategy

% Number of assez at our disposal
[N,T] = size(Weights);

sum = 0;
Turnover = zeros(length(Weights),1);

    for i=2:N-1
        for t=1:T
            sum = sum + abs(Weights(i,t)-(1+Returns(i,t))*Weights(i-1,t)/((Returns(i,:))*Weights(i,:)'+1));
        end
        
        %Turnover at time i in %
        Turnover(i) = sum;
        sum = 0;
    end
    
%Average Turnover
AverageTurnover = mean(Turnover);

end
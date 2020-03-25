function [c,ceq] = VolConstraintBaltas(x,Target,i,Weights,Returns,LengthMonth,LengthVol,position)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

        %Applicable Weights
        ApplicableWeights(1:length(indexAvailable)) = x(indexAvailable);
        
        for j = 1:round(LengthVol/LengthMonth,0) % Typically = 3 for vol 63, month 21
            for k = 1:sum(index)
            WeightedReturns((j-1)*LengthMonth+1:(j-1)*LengthMonth+LengthMonth,1:indexAvailable(k)) ...
            = ApplicableWeights(1:length(indexAvailable))*Returns(i+(j-1)*LengthMonth:...
            i+(j-1)*LengthMonth+LengthMonth-1,indexAvailable(k));
            end
        end

    %Computing the volatility of the matrix
    Vola = sqrt(252)*std(sum(WeightedReturns,2));
    
    c = Vola - Target;
    
    ceq = [];

end


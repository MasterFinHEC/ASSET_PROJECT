function [c,ceq] = VolConstraintBaltas(x,Target,i,Weights,Returns,LengthMonth,LengthVol,position)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 % ********************************
        % Computing the vector that will go in the vol. constraint.
        
        %Pre-allocating a matrix of returns 
        WeightedReturns = zeros(LengthVol,1); 
        
        % Positions of the available assets 
        indexAvailable = find(index==1);
    
            for j = 1:round(LengthVol/LengthMonth,0) % Typically = 3 for vol 63, month 21
                for k = 1:sum(index)
                            WeightedReturns((j-1)*LengthMonth+1:(j-1)*...
                            LengthMonth+LengthMonth,k) ...
                            = Returns(i+(j-1)*LengthMonth:...
                             i+(j-1)*LengthMonth+LengthMonth-1,indexAvailable(k));
                end
            end
        
    %Computing the volatility of the matrix
    Vola = sqrt(252)*std(sum(WeightedReturns,2));
    
    c = Vola - Target;
    
    ceq = [];

end


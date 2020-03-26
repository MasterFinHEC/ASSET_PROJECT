function [Fees] = FeesComputation(BpFee,Weights)
%Computing the Fees of the strategy
%   1. Find the difference in the Weights
%   2. if short 3bp if long 1 bp 
%   3. Multiply deltaWeights*bp*Price 

Delta = zeros(length(Weights),size(Weights,2));
Fees = zeros(length(Weights),size(Weights,2));

%Loop Computing the difference between the next and the previous weights
for i = 1:length(Weights)
    for j = 1:size(Weights,2)
       if i == 1 %No difference at the beginning (Wi - 0)
           
            Delta(i,j) = abs(Weights(i,j));
            
       elseif i == length(Weights) %Kill the entire position at the end
       
            Delta(i,j) = abs(Weights(i,j));
            
       else 
           
            Delta(i,j) = abs(Weights(i,j)-Weights(i-1,j));
            
       end 
       
       if i == 1
           
           if Weights(i,j) >= 0
               
            Fees(i,j) = Delta(i,j)*BpFee(1);
           
           else 
               
            Fees(i,j) = Delta(i,j)*BpFee(2);
            
           end
       elseif Weights(i-1,j) > 0 && Weights(i,j) >=0
        
           Fees(i,j) = Delta(i,j)*BpFee(1);
           
       elseif Weights(i-1,j) < 0 && Weights(i,j)  <= 0
           
           Fees(i,j) = Delta(i,j)*BpFee(1);
           
       elseif Weights(i-1,j) >= 0 && Weights(i,j) < 0
           
           Fees(i,j) = BpFee(1)*Weights(i-1,j)+BpFee(2)*abs(Weights(i,j));
           
       elseif Weights(i-1,j) <= 0 && Weights(i,j) > 0
           
           Fees(i,j) = BpFee(2)*abs(Weights(i-1,j))+BpFee(1)*Weights(i,j);
           
       end 
       
    end 
end

end


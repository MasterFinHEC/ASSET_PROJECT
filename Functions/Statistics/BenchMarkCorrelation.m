function [Neutral] = BenchMarkCorrelation(A,B)


% Creating vector of the same size
if length(A) < length(B)
    Z = length(B)-length(A);
    B = B(Z+1:end,:);
else
    Z = length(A)-length(B);
    A = A(Z+1:end,:);
end

% Pre alocating output
Neutral = zeros(1,size(B,2));

% Computing correlation
for i = 1:size(B,2)
    k = find(~ isnan (B(:,i)),1);
    R = corrcoef(A(k:end), B(k:end,i));
    Neutral(i) = R(2,1);
end
end


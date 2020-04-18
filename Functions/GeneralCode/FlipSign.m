function [Avg] = FlipSign(Weights1,Weights2)

for i = 1:size(Weights1,1)
    for j = 1:size(Weights1,2)
        if Weights1(i,j) == 0
    Weights1(i,j) = 0;
        elseif Weights1(i,j) <0
    Weights1(i,j) = -1;
        else 
    Weights1(i,j) = 1;
        end
    end
end

for i = 1:size(Weights2,1)
    for j = 1:size(Weights2,2)
        if Weights2(i,j) == 0
    Weights2(i,j) = 0;
        elseif Weights2(i,j) <0
    Weights2(i,j) = -1;
        else 
    Weights2(i,j) = 1;
        end
    end
end

count1 = 0;
count2 = 0;
for i = 1:size(Weights1,1)
    for j = 1:size(Weights1,2)
        if Weights1(i,j) ~= 0
            count1 = count1 + 1;
            if Weights1(i,j) == Weights2(i,j)
            count2 = count2 + 1;   
            end 
        end
    end
end

Avg = count2/count1;
disp(Avg)

end


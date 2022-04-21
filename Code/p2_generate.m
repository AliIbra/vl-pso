function [p2, p_2N] = p2_generate (pop, index, index2)

%% This function is used to select the second random particle for the K-Tournament selection process..
nElements = length(pop);
while (1)
    randID = randi([1 nElements]);
    if  randID ~= index && randID ~= index2
        rp = pop(randID);
        if length(pop(randID).Position) >= length(pop(index).Position) 
            p2 = rp;
            x = find(p2.Position >= 0.6);
            if any(x)
                break
            end
        else
            continue
        end
    end
end
p_2N = randID;
end
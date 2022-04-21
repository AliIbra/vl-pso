function [p1, p_1N] = p1_generate (pop, index)

%% This function is used to select the first random particle for the K-Tournament selection process.
nElements = length(pop);
while(1)
    randID = randi([1 nElements]);
    if  randID ~= index
        rp = pop(randID);
        if length(pop(randID).Position) >= length(pop(index).Position)
            p1 = rp;
            x = find(p1.Position >= 0.6);
            if any(x)
                break
            end
        else
            continue
        end
    end
end
p_1N = randID;
end
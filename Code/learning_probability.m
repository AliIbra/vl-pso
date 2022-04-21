% Done
function [pc, rank, index] = learning_probability ( nPop, index, rankedParticles)

for idx=1: nPop
    if idx == index
        rank = rankedParticles(idx, 1);
    else
        continue
    end
end

%% This Function Is Used To Calculate The Learning Probability of Each Particle
pc = 0.05 + 0.45 .*(exp((10.*(rank-1))/nPop -1) / exp(10-1));

end
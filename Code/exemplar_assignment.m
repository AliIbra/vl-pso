% Done
function exemplar = exemplar_assignment(pop, targetedPrticle, index, rankedFeatures, filePath, nFeatures, accMemory)

%% This Function Is Used To Assign An Exemplar To Each Particle In The Swarm
% Exemplar: a vector with the same length as the particle indecting the
% indexes of the best particles in each dimension

L = length(targetedPrticle.Position);
exemplar = targetedPrticle.Exemplar;
pc = targetedPrticle.Pc;                                % Particle's Learning Probability
for d = 1: L
    rnd = rand;                                             % Random Number drawn From a Uniformly Distribution 
    if(rnd > pc)
        exemplar(d) = index;
    else
        % Key Tournament
        [p1, p1Number] = p1_generate(pop,index);            % Generate The First Random Particle Function
        [p2, p2Number] = p2_generate(pop, index, p1Number); % Generate The First Random Particle Function
        % Calculate Fitness Values For Both Particles
        p1Fitness = fitness_function(p1, rankedFeatures, filePath, nFeatures, accMemory);
        p2Fitness = fitness_function(p2, rankedFeatures, filePath, nFeatures, accMemory);
        % Take The Best Particle Fitness Value
        if(p1Fitness > p2Fitness)
            exemplar(d) = p1Number;
        else
            exemplar(d) = p2Number;
        end
    end    
end
end
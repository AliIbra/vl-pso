function [newParLen, newMaxLen, particle]= length_changing (nPop, particle, nDivision, maxLen, divSize, parLen, rankedFeatures, filePath, maxVar, minVar, rankedParticles, nFeatures, accMemory)


fitness_all=[];
for d=1: nDivision
    fitness = 0;
    for idx=1: nPop
        if length(particle(idx).Position) == parLen(d)
            fitness = fitness + particle(idx).Fitness;
        end
    end
    fitness_all =[ fitness_all ; fitness/divSize  parLen(d)];
end

best_fitness = max(fitness_all(:,:));

newMaxLen = best_fitness(2);

if(newMaxLen ~= maxLen)
    % New Particles Length numbers
    for d=1:nDivision
        if parLen(d) == newMaxLen
            newParLen(d) = parLen(d);
            break;
        else
            newParLen(d) = newMaxLen * (k/nDivision);
        end
    end
else
    newParLen = parLen;
end
%% Change Particle's Length besad on the new numbers
for d=1: nDivision
    if parLen (d) < newMaxLen
        %% Append to particle
        for idx=1:nPop
            nExtra = newParLen(d) - parLen(d);
            for i=1:nExtra
                rndExtra = unifrnd(minVar, maxVar);
                particle(idx).Position = [particle(idx).Position, rndExtra];
                particle(idx).Velocity = [particle(idx).Position, 0];                
            end
            particle(idx).Fitness = fitness_function(particle(idx), rankedFeatures, filePath, nFeatures, accMemory);
            particle(idx).Pc = learning_probability(nPop, idx, rankedParticles);
        end
    elseif parLen(d) == newParLen               %% Same Length
        continue
    else
        %% Remove from the particle
        for idx=1:nPop
            nRemove = newParLen(d) - parLen(d);
            for i=1:nRemove
                particle(idx).Position(end) = [];
                particle(idx).Velocity(end) = [];
            end
            [particle(idx).Fitness, ~ , ~, accMemory, ~] = fitness_function(particle(idx), rankedFeatures, filePath, nFeatures, accMemory);
            particle(idx).Pc = learning_probability(nPop, idx, rankedParticles);
        end
    end
end
%% Assign New Exemplar
for idx=1: nPop
    particle(idx).Exemplar = exemplar_assignment(particle, particle(idx), idx, rankedFeatures, filePath, nFeatures, accMemory);
end
end
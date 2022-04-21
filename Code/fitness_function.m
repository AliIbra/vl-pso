% Done
function [fitness , distance, wrapper_value, accMemory, nActiveFeatures] = fitness_function(particle, rankedFeatures, filePath, nFeatures, accMemory)

%% This Function Is Used To Calculate the fitness for swarm's particles
% get_features Function: returns which features is included in the candidate solution (Particle)

gama = 0.9;
[involvedFeatures, s_index] = particle_features(particle);
nActiveFeatures = length(involvedFeatures);
if s_index == 0
    fitness = 0;
    distance = 0;
    wrapper_value = 0;
    nActiveFeatures = 0;
elseif accMemory(s_index,1) ~= 0
        fitness = accMemory(s_index, 1);
        distance = accMemory(s_index, 2);
        wrapper_value = accMemory(s_index, 3);
else
        particleFeatures = features_index(involvedFeatures, rankedFeatures);
        [x_train, y_train, x_test, y_test, train_distance] = choosen_subdata(filePath, particleFeatures,nFeatures);
        distance = filter_distance(train_distance);
        % particle_accuracy Function: returns accuracy of the selected features 
        wrapper_value = particle_accuracy(x_train, y_train, x_test, y_test);
        fitness = (gama * wrapper_value) + ((1-gama) * distance);
        accMemory(s_index, 1) = fitness;
        accMemory(s_index, 2) = distance;
        accMemory(s_index, 3)= wrapper_value ;
end

end
%% Done
function [features, dec_index] = particle_features(particle)

%% This Function Is To Examine If The Feature Is Selected Or Not
new_particle = particle;
features = [];
for i=1: length(new_particle.Position)
    if particle.Position(i) >= 0.2
        new_particle.Position(i) = 1;
    else
        new_particle.Position(i) = 0;
    end
end

dec_index = bi2de(new_particle.Position);

for d=1:length(new_particle.Position)
    if new_particle.Position(d) == 1
        features = [features , d];
    else
        continue;
    end
end
end
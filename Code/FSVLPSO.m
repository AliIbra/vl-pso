%% This is the main file of the algorithm you can change the parameters as they are exeplained in the comments
% you can change the name of the saved result file in each run, by changing
% the save path in the end of the file


clear all;

%% Read Wine Data
filePath = "..\Data\wine.data";

%% Problem Definition           
nVar = 12;                                      % Number of Decision Variables
VarSize =[1 nVar];                              % Size of Decision Variables Matrix
VarMin = 0;                                     % Lower Bound of Variables
VarMax = 1;                                     % Upper Bound of Variables

%% PSO Parameters
MaxIt = 200;                                     % Maximum Number of Iterations
nPop = 40;                                      % Population Size (Swarm Size)
w = 1;                                          % Inertia Weight
wdamp = 0.99;                                   % Inertia Weight Damping Ratio
pac = 1.49445;                                  % Personal Accleration Coefficient
showIterInfo = true;                            % Flag to Show Each Iteration Information 
alpha = 5;                                      % The max number of iterations that pbest has not been improved
beta = 5;                                       % The max number of iterations that gbest has not been improved
nDivision = 4;                                  % The number of division needed
nIterGbestDoesNotChanged = 0;                   % Number of iterations Global Best solution did not changed
nCombinations = (2.^(nVar)) -1;                 % Number of possible combinations of the features

%% Initialization
% Particle
empty_particle.Position = [];                   % Particle's Position in the search space
empty_particle.Velocity=[];                     % Particle's Velocity
empty_particle.Pc = 0;                          % Particle Learning Probability
empty_particle.Exemplar=[];                     % Particle Exemplar For Comparesion
empty_particle.Fitness = 0;                     % Particle's Fitness value
empty_particle.Accuracy = 0;                    % Particle's Accuracy
empty_particle.Distance = 0;                    % Particle's Distance measure to evaluate the features subset
empty_particle.nIterPbestDoesNotChanged = 0;    % The number of iterations a particle's pbest does not changed
empty_particle.nActiveFeatures = 0;             % The number of feeatures active in particle

particle=repmat(empty_particle, nPop, 1);
% Global Best
GlobalBest.Position = [];                       % Global Best Position in the current swarm
GlobalBest.Distance = [];                       % Global Best Distance in the current swarm
GlobalBest.Accuracy = [];                       % Global Best Accuracy in the current swarm 
GlobalBest.Fitness = [];                        % Global Best Fitness in the current swarm
GlobalBest.nActiveFeatures = 0;                 % Globel Best's number of feeatures active in particle

% Best Solution in each Iteration
BestSol.Position = [];                          % Best Solution's Position
BestSol.Distance = [];                          % Best Solution's Distance
BestSol.Accuracy= [];                           % Best Solution's Accuracy
BestSol.Fitness = [];                           % Best Solution's Fitness
BestSol.nFeatures = 0;                          % Best Solution's number of features

% Memory
accMemory = zeros(nCombinations, 3);

%% Population Division
[parLen, divSize, maxLen] = pop_division(nPop, nDivision, nVar);

%% Feature Ranking
[rankedFeatures] = feature_ranking(filePath, nVar);

%% Initialize The Population With Variable Length Settings
v = 1;
for idx=1:nPop
    particle(idx).Position = unifrnd(VarMin, VarMax, 1, parLen(v));
    x = find(particle(idx).Position >= 0.2);
    while ~any(x)
        particle(idx).Position = unifrnd(VarMin, VarMax, 1, parLen(v));
        x = find(particle(idx).Position >= 0.2);
    end
    particle(idx).Velocity = zeros(1,parLen(v));
    particle(idx).Exemplar = zeros(1,parLen(v));
    particle(idx).Best = particle(idx).Position;
    if mod(idx, divSize) == 0
        v = v + 1;
    end
end

%% Fitness Calculation 
for idx=1:nPop
    [particle(idx).Fitness, particle(idx).Distance , particle(idx).Accuracy, accMemory, particle(idx).nActiveFeatures] = fitness_function(particle(idx), rankedFeatures, filePath, nVar, accMemory);
end

%% Learning Probability FOr Each Particle
rankedParticles = particle_ranking(nPop, particle);
for idx=1:nPop
    particle(idx).Pc = learning_probability(nPop,idx, rankedParticles);
end

%% Exemplar Assignment
for idx=1:nPop
    particle(idx).Exemplar = exemplar_assignment(particle, particle(idx), idx, rankedFeatures, filePath, nVar, accMemory);
end

%% PSO Main Loop
for it=1:MaxIt
    for idx=1:nPop
        % Update Velocity
        for dim=1:length(particle(idx).Position)
            r = unifrnd(0,1);
            particle(idx).Velocity(dim) = w * particle(idx).Velocity(dim) + ...
                pac * r *(particle(particle(idx).Exemplar(dim)).Position(dim) - particle(idx).Position(dim));
        end
        
        len = length(particle(idx).Position);
        
        
        %% The bound check could be in two ways
        % defult: one is by taking the max or min values in the
        % search space
        % Or : uncomment the two lines to make the search space as a sphere
        for vel_v =1: len
            if particle(idx).Velocity < -1.0
                particle(idx).Velocity(vel_v) = -1.0;
%                 vel_mintg = fix(particle(idx).Velocity(vel_v));
%                 particle(idx).Velocity(vel_v) = particle(idx).Velocity(vel_v) + vel_mintg;
            end
            if particle(idx).Velocity(vel_v) > 1.0
                particle(idx).Velocity(vel_v) = 1.0;
%                 vel_intg = fix(particle(idx).Velocity(vel_v));
%                 particle(idx).Velocity(vel_v) = particle(idx).Velocity(vel_v) - vel_intg;
            else
                continue
            end
        end
        
        % Update Position
        particle(idx).Position = particle(idx).Position + particle(idx).Velocity;
        
        for pos_v=1:len
            if particle(idx).Position(pos_v) < 0
                particle(idx).Position(pos_v) =0.1;
%                particle(idx).Position(pos_v) = abs(particle(idx).Position(pos_v));
            end
            if particle(idx).Position(pos_v) > 1.0
                particle(idx).Position(pos_v) = 1.0;
%                 pos_intg = fix(particle(idx).Position(pos_v));
%                 particle(idx).Position(pos_v) = particle(idx).Position(pos_v) - pos_intg;
            else
                continue
            end
        end
        particle(idx).nActiveFeatures = 0;
        for i=1: len
            if particle(idx).Position(i) >= 0.2
                particle(idx).nActiveFeatures = particle(idx).nActiveFeatures + 1;
            end
        end
        
        %% Update Fitness
        pFitness_memorey = particle(idx).Fitness;                                % Save the previous fitness value
        [particle(idx).Fitness,particle(idx).Distance, particle(idx).Accuracy, accMemory, particle(idx).nActiveFeatures]  = fitness_function(particle(idx), rankedFeatures, filePath, nVar, accMemory);
        % Compare the two position based on the fitness
        if (particle(idx).Fitness > pFitness_memorey)
            particle(idx).Best = particle(idx).Position;
            particle(idx).nIterPbestDoesNotChanged = 0;
        else
            particle(idx).nIterPbestDoesNotChanged = particle(idx).nIterPbestDoesNotChanged + 1;
            if particle(idx).nIterPbestDoesNotChanged > alpha
                %% Update Learning Probabitility and Reassign Exemplar
                rankedParticles = particle_ranking(nPop, particle);
                for temp_j=1:nPop
                    particle(temp_j).Pc = learning_probability(nPop,temp_j, rankedParticles);
                end
                for temp_j=1:nPop
                    particle(temp_j).Exemplar = exemplar_assignment(particle, particle(temp_j), temp_j, rankedFeatures, filePath, nVar, accMemory);
                end
                particle(idx).nIterPbestDoesNotChanged = 0;
            end
        end
        
        %% Global Best
        if (idx == 1)
            GlobalBest.Fitness = particle(idx).Fitness;
            GlobalBest.Position = particle(idx).Position;
            GlobalBest.Distance = particle(idx).Distance;
            GlobalBest.Accuracy = particle(idx).Accuracy;
            GlobalBest.nActiveFeatures = particle(idx).nActiveFeatures;
        else
            if (particle(idx).Fitness > GlobalBest.Fitness)
                GlobalBest.Fitness = particle(idx).Fitness;
                GlobalBest.Position = particle(idx).Position;
                GlobalBest.Distance = particle(idx).Distance;
                GlobalBest.Accuracy = particle(idx).Accuracy;
                GlobalBest.nActiveFeatures = particle(idx).nActiveFeatures;
            end
        end 
    end
%% Best soluion in each iteration    
BestSol(it).Fitness = GlobalBest.Fitness;
BestSol(it).Position = GlobalBest.Position;
BestSol(it).nFeatures = GlobalBest.nActiveFeatures;
BestSol(it).Distance = GlobalBest.Distance;
BestSol(it).Accuracy = GlobalBest.Accuracy;
if it == 1
    continue
else
    %% Check if length will be changed
    if BestSol(it).Fitness == BestSol(it-1).Fitness
        nIterGbestDoesNotChanged = nIterGbestDoesNotChanged + 1;
        if nIterGbestDoesNotChanged > beta
          [parLen, maxLen, particle] = length_changing (nPop, particle, nDivision, maxLen, divSize, parLen, rankedFeatures, filePath, VarMax, VarMin, rankedParticles, nVar, accMemory);
          nIterGbestDoesNotChanged = 0;
        end
    else
        nIterGbestDoesNotChanged = 0;
    end
end

    w = w * wdamp;
end

%% Saving
save('..\Results\Sol_3.mat','BestSol');
function fitness_average = MY_OPTIMIZER(FUN, DIM, ftarget, maxfunevals)
% MY_OPTIMIZER(FUN, DIM, ftarget, maxfunevals)
% samples new points uniformly randomly in [-5,5]^DIM
% and evaluates them on FUN until ftarget of maxfunevals
% is reached, or until 1e8 * DIM fevals are conducted.

INPUT_NODES = 10 * rand(1, DIM) - 5; %Generate new random inputs between -5 and 5
GA_SOLUTIONS_SIZE = 800;
NODES = [DIM,5,1,0,0,0,0];
TRAINING_ITERATIONS = 50;

                                    %Matrix repesentation of layers
                                    %[2,5,2,0,0,0,0] specifies a neural network with 2 input nodes, 5
                                    %hidden nodes on one layer and 2 output nodes. Each array must have 7
                                    %values, max 5 hidden layers allowed

maxfunevals = min(1e8 * DIM, maxfunevals);
popsize = min(maxfunevals, 200);

    %Main body of code: all stems from above capitalised user-defined variables

node_layer_1 = INPUT_NODES;

[tr,tc] = size(node_layer_1); %Checking that the number of input nodes matches the number defined in NODES
if(NODES(1)~=tc)
    error('Number of input values do not match the number of nodes defined in Neural Network definition');
end

weights_total = NODES(1)*NODES(2) + NODES(2)*NODES(3) + NODES(3)*NODES(4) + NODES(4)*NODES(5) + NODES(5)*NODES(6) + NODES(6)*NODES(7);
    %Calculating number of weights generated by connections between nodes

population_ga = zeros(GA_SOLUTIONS_SIZE,weights_total);
population_ga = genetic_initialise(population_ga); %Initialise genetic algorithm with random weights

for i = 1:7         %Setting output layer as defined by 0's in NODES definition
    if(NODES(i)==0) %If the next number of nodes in NODES is 0
        hc = i-1;   %The output_layer must have been the layer before
        output_size = (NODES(i-1));
        break;
    end
end

[ node_layer_2,node_layer_3,node_layer_4,node_layer_5,node_layer_6,node_layer_7 ] = generate_node_layer( hc , NODES );

gen = zeros(output_size,GA_SOLUTIONS_SIZE);

[n1r,n1c] = size(node_layer_1);
[n2r,n2c] = size(node_layer_2);
[n3r,n3c] = size(node_layer_3);
[n4r,n4c] = size(node_layer_4);
[n5r,n5c] = size(node_layer_5);
[n6r,n6c] = size(node_layer_6);
[n7r,n7c] = size(node_layer_7);

weights_i1 = zeros(n1c,n2c);
weights_12 = zeros(n2c,n3c);
weights_23 = zeros(n3c,n4c);
weights_34 = zeros(n4c,n5c);
weights_45 = zeros(n5c,n6c);
weights_5o = zeros(n6c,n7c);

fbest = inf;

for chromosome = 1:GA_SOLUTIONS_SIZE
    [weights_i1,weights_12,weights_23,weights_34,weights_45,weights_5o] = concatenate_weights(n1c,n2c,n3c,n4c,n5c,n6c,n7r,population_ga(chromosome,:));
    gen(:,chromosome) = neural_network_iteration(node_layer_1,weights_i1,weights_12,weights_23,weights_34,weights_45,weights_5o);
end

xpop = transpose(INPUT_NODES);
expected = feval(FUN,xpop);     %Generate expected solutions

for i = 1:GA_SOLUTIONS_SIZE
    fitness(i) = calculate_fitness(gen(i),expected);    %calculate fitnesses of each solution
end

[values,index] = sort(fitness,'descend'); %Sort fitness solutions from best to worst

population_ga = genetic_reproduction(population_ga,index);  %Initial crossover and mutate of the population
population_ga = genetic_mutation(population_ga,index);

program_termination = 0; %Indication of how many training iterations happened (incase of error)

fitness_average = 0; %Used for calculating the average fitness for the run

for iter = 1:ceil(maxfunevals/popsize)
    
    for g = 1:TRAINING_ITERATIONS
        
        program_termination = program_termination + 1;
        
        INPUT_NODES = 10 * rand(1, DIM) - 5;      % New random inputs

        %For each chromosome (weight solution) in GA, iterate through Neural
        %Network and store the result
        for chromosome = 1:GA_SOLUTIONS_SIZE
            concatenate_weights(n1c,n2c,n3c,n4c,n5c,n6c,n7r,population_ga(chromosome,:));
            gen(:,iter) = neural_network_iteration(node_layer_1,weights_i1,weights_12,weights_23,weights_34,weights_45,weights_5o);
        end
        
        xpop = transpose(INPUT_NODES);
        
        expected = feval(FUN,xpop);
        
        for i = 1:GA_SOLUTIONS_SIZE
            fitness(i) = calculate_fitness(gen(i),expected); %Compare expected to generated and evaluate fitness
        end
        [values,index] = sort(fitness,'descend');
        
        best_generated(g) = gen(index(1));  %Used when plotting iteration
        solutions_expected(g) = expected;       %by iteration
        
        fitness_average = fitness_average + values(1);
        
        population_ga = genetic_reproduction(population_ga,index); %Crossover population
        population_ga = genetic_mutation(population_ga,index);  %Mutate population
        
        if fbest > values(1) % Keep best
            fbest = values(1);
            xbest = fbest;
        end
        
        population_ga = genetic_reproduction(population_ga,index); %Create new population from fitnesses using genetic algorithm
        population_ga = genetic_mutation(population_ga,index);
        
        if feval(FUN, 'fbest') < ftarget         % COCO-task achieved
            break; 
        end
    end
    
%     figure;
%     plotdata(solutions_expected,best_generated,program_termination);
    
    fitness_average = (fitness_average)/TRAINING_ITERATIONS;
end
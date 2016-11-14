function population = genetic_initialise( population )
%Initialise the population with random values

a = 1000;
b = -1000;

    [pr,pc] = size(population); %Get row and column value

    for i = 1:pr %Initialise population to random
        for j = 1:pc
          population(i,j) = (b-a).*rand(1,1) + a;
            %Running genetic_algorithm
        end
    end
end


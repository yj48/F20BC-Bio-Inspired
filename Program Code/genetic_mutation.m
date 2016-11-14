function new_population = genetic_mutation( population, fitness )
%Mutate the population

mut_select = zeros(1,2);
[mr,mc] = size(mut_select); %Get row and column value
[pr,pc] = size(population);

new_population = population;

for m = 1:mc
   random_index_population = randi([1 pr],1,1);
   number_of_mutts = randi([1 pc],1,1); %Generate a random number of mutations
   temp = zeros(1,pc);
   random_indexes = randi([1 pc],1,number_of_mutts);
        %Generate a random number of points at which to mutate
   for i = 1:pc    %Mutate and create the mutated solution
       if any(random_indexes==i)
          temp(i) = randi([1 pc],1,1);
       else
          temp(i) = population(random_index_population,i);
       end
   end
   new_population((m+8),:) = temp(:); %Store the mutated solution
end


end


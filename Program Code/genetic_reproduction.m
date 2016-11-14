function new_population = genetic_reproduction( population,fitness )
%Reproduction. That is all. Reproduction happens

[pr,pc] = size(population); %Get row and column value

%[sortedX,sortingIndices] = sort(fitness,'descend'); %This is used when genetic algorithm is being run
sortingIndices = fitness;   %This is used when COCO (example experiments) is being run

random_split = randi([1 pc],1,1); %Make sure the splits aren't the first or last value
while(random_split == pc | random_split == 1)
    random_split = randi([1 pc],1,1);
end

random_1 = randi([1 random_split],1,1); %Generate two random splitting points
random_2 = randi([random_split pc],1,1); %Used for two-point crossover reproduction

while(random_1 == random_2) %Make sure the two splits aren't the same point
   random_2 = randi([random_split pc],1,1);
end

new_population = zeros(pr,pc); %New solutions stored in new_population

for i = 1:(pr/2)     %Two-point parent crossover
   for k = 1:random_1
       new_population(i,k) = population(sortingIndices(i),k);
   end
   for k = random_1:random_2
       new_population(i,k) = population(sortingIndices((i+1)),k);
   end
   for k = random_2:pc
       new_population(i,k) = population(sortingIndices(i),k);
   end
end

new_population((pr-4),:) = population(sortingIndices(1),:); %Take best from population
new_population((pr-3),:) = population(sortingIndices(2),:); %Take second best from population
new_population((pr-2),:) = population(sortingIndices(pr),:); %Take worst from population (because why not)


end


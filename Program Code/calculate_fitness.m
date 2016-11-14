function [ fitness ] = calculate_fitness( generated,expected )
%Fitness of generated value compared to expected value

g = abs(generated);
e = abs(expected);

%Checking how close the generated is to the expected, and adding 1/(that
%number) to the fitness

f = abs(g-e);
f = 1/f;

if(expected>=0)
    %Checking if same sign (if so, fitness is positive, if not fitness is
    %negative)
    if(generated>=0)
        f = f;
    else
        f = -1*f;
    end
elseif(expected<0)
    if(generated<0)
        f = f;
    else
        f = -1*f;
    end
end

fitness = f; %Return fitness

end


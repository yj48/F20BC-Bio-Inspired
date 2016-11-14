function [weights_i1,weights_12,weights_23,weights_34,weights_45,weights_5o ] = concatenate_weights( input_nodes,hidden_nodes_1,hidden_nodes_2,hidden_nodes_3,hidden_nodes_4,hidden_nodes_5,output_nodes,ga_list )
%Function concatenates list of weights into matrices

counter = 0;
rows_i1 = input_nodes;
columns_i1 = hidden_nodes_1;
rows_12 = hidden_nodes_1;
columns_12 = hidden_nodes_2;
rows_23 = hidden_nodes_2;
columns_23 = hidden_nodes_3;
rows_34 = hidden_nodes_3;
columns_34 = hidden_nodes_4;
rows_45 = hidden_nodes_4;
columns_45 = hidden_nodes_5;
rows_5o = hidden_nodes_5;
columns_5o = output_nodes;

check = input_nodes*hidden_nodes_1 + hidden_nodes_1*hidden_nodes_2 + hidden_nodes_2*hidden_nodes_3 + hidden_nodes_3*hidden_nodes_4 + hidden_nodes_4*hidden_nodes_5 + hidden_nodes_5*output_nodes;
check_size = size(ga_list); %Compare the number of nodes with the size of the GA to verify the correct number of weights generated
if(check~=check_size)
    error('Nodes do not match number of weights generated');
end

%Initialise matrices

weights_i1 = [];
weights_12 = [];
weights_23 = [];
weights_34 = [];
weights_45 = [];
weights_5o = [];

%Generate weight matrices based on the current iteration of the GA

for a=1:rows_i1
    for b=1:columns_i1
        counter = counter+1;
        weights_i1(a,b) = ga_list(counter);
    end
end

for a=1:rows_12
    for b=1:columns_12
        counter = counter+1;
        weights_12(a,b) = ga_list(counter);
    end
end

for a=1:rows_23
    for b=1:columns_23
        counter = counter+1;
        weights_23(a,b) = ga_list(counter);
    end
end

for a=1:rows_34
    for b=1:columns_34
        counter = counter+1;
        weights_34(a,b) = ga_list(counter);
    end
end

for a=1:rows_45
    for b=1:columns_45
        counter = counter+1;
        weights_45(a,b) = ga_list(counter);
    end
end

for a=1:rows_5o
    for b=1:columns_5o
        counter = counter+1;
        weights_5o(a,b) = ga_list(counter);
    end
end


end


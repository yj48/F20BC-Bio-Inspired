function [ output_node ] = neural_network_iteration( input_node,weights_i1,weights_12,weights_23,weights_34,weights_45,weights_5o )
%Function iterates through one instance of the neural network
%   Based on weights, input values and logsig activation functions

[n12r,n12c] = size(weights_i1);
[n23r,n23c] = size(weights_12);
[n34r,n34c] = size(weights_23);
[n45r,n45c] = size(weights_34);
[n56r,n56c] = size(weights_45);
[n67r,n67c] = size(weights_5o);

if(isempty(weights_23)) %Determine output later and stopping condition
   stop_at = 3; 
elseif(isempty(weights_34))
   stop_at = 4;
elseif(isempty(weights_45))
    stop_at = 5;
elseif(isempty(weights_5o))
    stop_at = 6;
else
    stop_at = 7;
end

node_layer_1 = input_node;
node_layer_2 = zeros(1,n12c);
node_layer_3 = zeros(1,n23c);
node_layer_4 = zeros(1,n34c);
node_layer_5 = zeros(1,n45c);
node_layer_6 = zeros(1,n56c);
node_layer_7 = zeros(1,n67c);

%Calculate values at each node layer based on weights and previous inputs

for i = 1:n12c
    for j = 1:n12r
        node_layer_2(i);
        weights_i1(j,i);
        node_layer_1(1,j);
        node_layer_2(i) = node_layer_2(i)+weights_i1(j,i).*node_layer_1(1,j);
    end
    node_layer_2(i) = logsig(node_layer_2(i));
end

for i = 1:n23c
    for j = 1:n23r
        node_layer_3(i) = node_layer_3(i)+weights_12(j,i).*node_layer_2(j);
        %Node i at layer 3 = Sum of all weights going to it multiplied by
        %the value of the previous node
    end
    if(stop_at == 3) %If 3 is the last layer, the output layer is layer 3
        output_node = node_layer_3;
    else
        node_layer_3(i) = logsig(node_layer_3(i)); %Put through logsig activation function
    end
end

for i = 1:n34c
    for j = 1:n34r
        node_layer_4(i) = node_layer_4(i)+weights_23(j,i).*node_layer_3(j);
    end
    if(stop_at == 4)
        output_node = node_layer_4;
    else
        node_layer_4(i) = logsig(node_layer_4(i));
    end
end

for i = 1:n45c
    for j = n45r
        node_layer_5(i) = node_layer_5(i)+weights_34(j,i).*node_layer_4(j);
    end
    if(stop_at == 5)
        output_node = node_layer_5;
    else
        node_layer_5(i) = logsig(node_layer_5(i));
    end
end

for i = 1:n56c
    for j = 1:n56r
        node_layer_6(i) = node_layer_6(i)+weights_45(j,i).*node_layer_5(j);
    end
    if(stop_at == 6)
        output_node = node_layer_6;
    else
        node_layer_6(i) = logsig(node_layer_6(i));
    end
end

for i = 1:n67c
    for j = 1:n67r
        node_layer_7(i) = node_layer_7(i)+weights_5o(j,i).*node_layer_6(j);
    end
    if(stop_at == 7)
        output_node = node_layer_7;
    end
end

end


function [ node_layer_2,node_layer_3,node_layer_4,node_layer_5,node_layer_6,node_layer_7 ] = generate_node_layer( hc , NODES )
%Function generates layers of nodes from weights
%Starts at node_layer_2 because node_layer_1 = inputs

if (hc == 3) %Creating node_layer matrices with nodes
   node_layer_2 = zeros(1,NODES(1,2));
   node_layer_3 = zeros(1,NODES(1,3));
   node_layer_4 = [];
   node_layer_5 = [];
   node_layer_6 = [];
   node_layer_7 = [];
elseif (hc == 4)
   node_layer_2 = zeros(1,NODES(1,2));
   node_layer_3 = zeros(1,NODES(1,3));
   node_layer_4 = zeros(1,NODES(1,4));
   node_layer_5 = [];
   node_layer_6 = [];
   node_layer_7 = [];
elseif (hc == 5)
   node_layer_2 = zeros(1,NODES(1,2));
   node_layer_3 = zeros(1,NODES(1,3));
   node_layer_4 = zeros(1,NODES(1,4));
   node_layer_5 = zeros(1,NODES(1,5));
   node_layer_6 = [];
   node_layer_7 = [];
elseif (hc == 6)
   node_layer_2 = zeros(1,NODES(1,2));
   node_layer_3 = zeros(1,NODES(1,3));
   node_layer_4 = zeros(1,NODES(1,4));
   node_layer_5 = zeros(1,NODES(1,5));
   node_layer_6 = zeros(1,NODES(1,6));
   node_layer_7 = [];
elseif (hc == 7)
   node_layer_2 = zeros(1,NODES(1,2));
   node_layer_3 = zeros(1,NODES(1,3));
   node_layer_4 = zeros(1,NODES(1,4));
   node_layer_5 = zeros(1,NODES(1,5));
   node_layer_6 = zeros(1,NODES(1,6));
   node_layer_7 = zeros(1,NODES(1,7));
end    


end


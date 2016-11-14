function [ void ] = plotdata( expected, generated, range )
%This function plots and formats data

x = [0:1:(range-1)];
%axis = ([-1,range,-1,600]);
y = expected;
z(1:range) = generated;

title('Expected values from COCO vs Neural Network Generated Values');
xlabel('Iterations');
ylabel('Values');

hold on
    plot(x,y);
    plot(x,z);
    legend('Expected','Generated','Location','Southwest');
    drawnow;
    pause(0.05);
hold off

end
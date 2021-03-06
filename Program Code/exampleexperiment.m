% runs an entire experiment for benchmarking MY_OPTIMIZER
% on the noise-free testbed. fgeneric.m and benchmarks.m
% must be in the path of Matlab/Octave
% CAPITALIZATION indicates code adaptations to be made

addpath('C:/Users/Yola/Documents/MATLAB');  % should point to fgeneric.m etc.
datapath = 'PUT_MY_BBOB_DATA_PATH';  % different folder for each experiment
% opt.inputFormat = 'row';
opt.algName = 'PUT ALGORITHM NAME';
opt.comments = 'PUT MORE DETAILED INFORMATION, PARAMETER SETTINGS ETC';
maxfunevals = '10 * dim'; % 10*dim is a short test-experiment taking a few minutes 
                          % INCREMENT maxfunevals successively to larger value(s)
minfunevals = 'dim + 2';  % PUT MINIMAL SENSIBLE NUMBER OF EVALUATIONS for a restart
maxrestarts = 1e4;        % SET to zero for an entirely deterministic algorithm
%maxrestarts = 0;

%dimensions = [2, 3, 5, 310, 20, 40];  % small dimensions first, for CPU reasons
dimensions = [2,16];
functions = benchmarks('FunctionIndices');  % or benchmarksnoisy(...)
instances = [1:5, 41:50];  % 15 function instances
%instances = [1:5];
%instances = [5];

more off;  % in octave pagination is on by default

t0 = clock;
rand('state', sum(100*t0));

for dim = dimensions
  for ifun = functions
    for iinstance = instances
      fgeneric('initialize', ifun, iinstance, datapath, opt); 

      % independent restarts until maxfunevals or ftarget is reached
      for restarts = 0:maxrestarts
        if restarts > 0  % write additional restarted info
          fgeneric('restart', 'independent restart')
        end
        fitness_over_time((iinstance+1)) = MY_OPTIMIZER('fgeneric', dim, fgeneric('ftarget'), ...
                     eval(maxfunevals) - fgeneric('evaluations'));
               disp(fitness_over_time((iinstance+1)));
        if fgeneric('fbest') < fgeneric('ftarget') || ...
           fgeneric('evaluations') + eval(minfunevals) > eval(maxfunevals)
          break;
        end 
      end

      disp(sprintf(['  f%d in %d-D, instance %d: FEs=%d with %d restarts,' ...
                    ' fbest-ftarget=%.4e, elapsed time [h]: %.2f'], ...
                   ifun, dim, iinstance, ...
                   fgeneric('evaluations'), ...
                   restarts, ...
                   fgeneric('fbest') - fgeneric('ftarget'), ...
                   etime(clock, t0)/60/60));

      fgeneric('finalize');
    end
    disp(['      date and time: ' num2str(clock, ' %.0f')]);
    disp(fitness_over_time);
    
    %Comment This Block for Iterations
    figure;
    hold on;
    fitness = (fitness_over_time(:,[1:5,41:50]));
    xlabel('Iterations');
    ylabel('Average Fitness');
    title('Fitness over Iterations');
    plot(fitness);
    hold off;
    drawnow;
    pause(0.05);
    
  end
  disp(sprintf('---- dimension %d-D done ----', dim));
  
end


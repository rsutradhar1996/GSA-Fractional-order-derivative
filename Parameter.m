% ORDER BASELINE VALUES
alpha1=0.5;    % 1
alpha2=0.5;            % 2    
alpha3=0.5;    % 3         	
alpha4=0.5;              % 4  
dummy=1;            % 10
% ORDER Labels 
PRCC_var={'\alpha_1', '\alpha_2', '\alpha_3','\alpha_4','dummy'};% 

%% TIME SPAN OF THE SIMULATION
t_end=1000; % length of the simulations
tspan=(0:1:t_end);   % time points where the output is calculated
%time_points=[50 100 150 200 250 300 350 400 450]; % time points of interest for the US analysis
time_points=1:1:1000;
% INITIAL CONDITION FOR THE ODE MODEL
X0 = 8.53.*10^8;
Y0 = 0 ;
U0 = 0;
V0 = 1000;
y0 = [X0, Y0, U0, V0];

% Variables Labels
y_var_label={'X','Y','U','V'};

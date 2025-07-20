clear all;
close all;
%%
%% sample size N
runs=1000;
%% Base value of fractional order
alpha1=0.5;
alpha2=0.5;
alpha3=0.5;
alpha4=0.5;
%%LHS MATRIX
Parameter;
 min_v=[0.1 0.1 0.1 0.1]; % minimum value of orders
 max_v=[1 1 1 1]; % maximum value of orders


alpha1_LHS = LHSmatCal(min_v(1), alpha1, max_v(1), 0, runs, 'unif'); %1
alpha2_LHS = LHSmatCal(min_v(2), alpha2, max_v(2), 0, runs, 'unif'); %2
alpha3_LHS = LHSmatCal(min_v(3), alpha3, max_v(3), 0, runs, 'unif'); %3
alpha4_LHS = LHSmatCal(min_v(4), alpha4, max_v(4), 0, runs, 'unif'); %4
dummy_LHS = LHSmatCal(1,1,10,0,runs,'unif');

%%LHS MATRIX AND PARAMTER LABEL
LHSmatrix=[alpha1_LHS alpha2_LHS alpha3_LHS alpha4_LHS dummy_LHS];
% LHSmatrix1=[alpha1_LHS alpha2_LHS alpha3_LHS alpha4_LHS dummy_LHS];
%  Run solution x time choosing different value
%%
for x=1:runs
    %f=@ODE_LHS_me_1;
    t0 = 0;
    T=1500;
    h=2^(-7); 
    e=[8.53*10^8;3.3*10^8;5.36*10^10;1.23*10^10];
    E(4,3)=0;
    E(1:4,1)=e.*1;    
    E(1:4,2)=e.*0.5;    
    E(1:4,3)=e.*1.5;
    lambda=2.6*10^7;             
    mu=0.01;                     
    k=1.67*10^(-12);                   	
    a=150;                     
    beta=0.87;                  
    delta=0.053;               
    c=3.8;                     
    gamma=log(2);                 
    eta=0.8;
    par=[lambda mu k a beta delta c gamma eta];
    R0=a*k*lambda*eta*beta/(delta*c*(eta*beta-gamma+eta*beta+delta)*mu);
    x
    alpha1=LHSmatrix(x,1);
    alpha2=LHSmatrix(x,2);
    alpha3=LHSmatrix(x,3);
    alpha4=LHSmatrix(x,4);
    %dummy_LHS=LHSmatrix(x,5);
    alphaorder=LHSmatrix(x,1:4);
    f_fun = @(t,y) [lambda-mu.*y(1)-k.*y(1).*y(4); k.*y(1).*y(4)-delta.*y(2); 
    a.*y(2)+gamma.*(1-eta).*y(3)-eta.*beta.*y(3)-delta.*y(3); eta.*beta.*y(3)-c.*y(4)] ; % function
    %J_fun = @(t,y,par) [-(par(2)+1) + 2*y(1)*y(2) , y(1)^2 ; par(2) - 2*y(1)*y(2), -y(1)^2] ;   % Jacobian function

   % [t,y]=fde_pi2_im(alphaorder,f_fun,J_fun,t0,T,E(1:4,1),h,par);
     [t,y]=fde_pi1_ex(alphaorder,f_fun,t0,T,E(1:4,1),h);

    %[t,y]=ode15s(@(t,y)f(t,y,LHSmatrix,x,runs),tspan,y0,[]);
    A=[t' y']; % [time y]
    %% Save only the outputs at the time points of interest [time_points]:
    %% MORE EFFICIENT
    X_lhs(:,x)=A(time_points+1,2);
    Y_lhs(:,x)=A(time_points+1,3);
    U_lhs(:,x)=A(time_points+1,4);
    V_lhs(:,x)=A(time_points+1,5);
end
%% Save the workspace
%save Model_LHS_me_1.mat;
%CALCULATE PRCC

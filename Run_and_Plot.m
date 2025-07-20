% Runing and Ploting of all graph
 
%% Fisrt run these two.

 Parameter;
 Model_FDE;

%% Scatter plots
% Uninfected hepatocytes
 [PrccValue_x,Pvalue_x]=PRCC_Cal_Scatter_Plot(LHSmatrix, X_lhs, 800, PRCC_var, y_var_label(1));

% Infected hepatocytes
 [PrccValue_y,Pvalue_y]=PRCC_Cal_Scatter_Plot(LHSmatrix, Y_lhs, 800, PRCC_var, y_var_label(2));

% HBV Capsids
 [PrccValue_u,Pvalue_u]=PRCC_Cal_Scatter_Plot(LHSmatrix, U_lhs, 800, PRCC_var, y_var_label(3));

% Viruses
 [PrccValue_v,Pvalue_v]=PRCC_Cal_Scatter_Plot(LHSmatrix, V_lhs, 800, PRCC_var, y_var_label(4));
%%

%% Hexagonal  plots
% Uninfected hepatocytes
 [PrccValue_x,Pvalue_x]=PRCC_Cal_Hex_Plot(LHSmatrix, X_lhs, 600, PRCC_var, y_var_label(1));

% Infected hepatocytes
 [PrccValue_y,Pvalue_y]=PRCC_Cal_Hex_Plot(LHSmatrix, Y_lhs, 600, PRCC_var, y_var_label(2));

% HBV Capsids
 [PrccValue_u,Pvalue_u]=PRCC_Cal_Hex_Plot(LHSmatrix, U_lhs, 600, PRCC_var, y_var_label(3));

% Viruses
 [PrccValue_v,Pvalue_v]=PRCC_Cal_Hex_Plot(LHSmatrix, V_lhs, 600, PRCC_var, y_var_label(4));
%%






%%  PRCC values for all time points: Long term dynamics of PRCC values and P-values
% PRCC value
prcc_value_collect_x(1000,5)=0;
prcc_value_collect_y(1000,5)=0;
prcc_value_collect_u(1000,5)=0;
prcc_value_collect_v(1000,5)=0;

% P-value
P_value_collect_x(1000,5)=0;
P_value_collect_y(1000,5)=0;
P_value_collect_u(1000,5)=0;
P_value_collect_v(1000,5)=0;

for i=1:1:1000
% Uninfected hepatocytes   
[Prcc_value_x,P_value_x]=PRCC_Cal_Scatter_Plot(LHSmatrix, X_lhs, i, PRCC_var, y_var_label(1));
prcc_value_collect_x(i,:)=Prcc_value_x;
P_value_collect_x(i,:)=P_value_x;

% Infected hepatocytes
[Prcc_value_y,P_value_y]=PRCC_Cal_Scatter_Plot(LHSmatrix, Y_lhs, i, PRCC_var, y_var_label(2));
prcc_value_collect_y(i,:)=Prcc_value_y;
P_value_collect_y(i,:)=P_value_y;

% HBV Capsids
[Prcc_value_u,P_value_u]=PRCC_Cal_Scatter_Plot(LHSmatrix, U_lhs, i, PRCC_var, y_var_label(3));
prcc_value_collect_u(i,:)=Prcc_value_u;
P_value_collect_u(i,:)=P_value_u;

% Viruses
[Prcc_value_v,P_value_v]=PRCC_Cal_Scatter_Plot(LHSmatrix, V_lhs, i, PRCC_var, y_var_label(4));
prcc_value_collect_v(i,:)=Prcc_value_v;
P_value_collect_v(i,:)=P_value_v;
end

% save data
writematrix(prcc_value_collect_x, 'prcc_value_collect_x.xlsx');
writematrix(prcc_value_collect_y, 'prcc_value_collect_y.xlsx');
writematrix(prcc_value_collect_u, 'prcc_value_collect_u.xlsx');
writematrix(prcc_value_collect_v, 'prcc_value_collect_v.xlsx');

writematrix(P_value_collect_x, 'P_value_collect_x.xlsx');
writematrix(P_value_collect_y, 'P_value_collect_y.xlsx');
writematrix(P_value_collect_u, 'P_value_collect_u.xlsx');
writematrix(P_value_collect_v, 'P_value_collect_v.xlsx');
%%

















%% CC Plot
%CC_PLOT_me(LHSmatrix,V_lhs,1,'lin',PRCC_var,y_var_label)
%% RCC Plot
% RCC_PLOT_me(LHSmatrix,V_lhs,1,'lin',PRCC_var,y_var_label)


% figure(1)
% subplot(2,2,1)
% plot(t,y( :,1),'r--','linewidth',2);
% subplot(2,2,2)
% plot(t,y( :,2),'r--','linewidth',2);
% subplot(2,2,3)
% plot(t,y( :,3),'r--','linewidth',2);
% subplot(2,2,4)
% plot(t,y( :,4),'r--','linewidth',2);
%X_plot
%  for i=1:9
%     figure(i+1)
%     PRCC_PLOT_me(LHSmatrix, V_lhs, i, PRCC_var, y_var_label(1))
%     hold on
%  end
% Generate sample data

clc;
clear all;
TPx = readtable('P_value_collect_x.xlsx');
TPy = readtable('P_value_collect_y.xlsx');
TPu = readtable('P_value_collect_u.xlsx');
TPv = readtable('P_value_collect_v.xlsx');
data1x = table2array(TPx);
data1y = table2array(TPy);
data1u = table2array(TPu);
data1v = table2array(TPv);
t=1:1:1000;

figure(1)
subplot(2,2,1)
plot(t(1:10:1000),data1x(1:10:1000,1:4),'LineWidth',2)
legend('\alpha_1', '\alpha_2','\alpha_3','\alpha_4');
xlabel('Time (day)');
ylabel('P-value-X')
set(gca, 'FontWeight', 'bold');

subplot(2,2,2)
plot(t(1:10:1000),data1y(1:10:1000,1:4),'LineWidth',2)
legend('\alpha_1', '\alpha_2','\alpha_3','\alpha_4');
xlabel('Time (day)');
ylabel('P-value-Y')
set(gca, 'FontWeight', 'bold');

subplot(2,2,3)
plot(t(1:10:1000),data1u(1:10:1000,1:4),'LineWidth',2)
legend('\alpha_1', '\alpha_2','\alpha_3','\alpha_4');
xlabel('Time (day)');
ylabel('P-value-U')
set(gca, 'FontWeight', 'bold');

subplot(2,2,4)
plot(t(1:10:1000),data1v(1:10:1000,1:4),'LineWidth',2)
legend('\alpha_1', '\alpha_2','\alpha_3','\alpha_4');
xlabel('Time (day)');
ylabel('P-value-V')
set(gca, 'FontWeight', 'bold');

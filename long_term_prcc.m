clc;
clear all;
Tx = readtable('prcc_value_collect_x.xlsx');
Ty = readtable('prcc_value_collect_y.xlsx');
Tu = readtable('prcc_value_collect_u.xlsx');
Tv = readtable('prcc_value_collect_v.xlsx');
data1x = table2array(Tx);
data1y = table2array(Ty);
data1u = table2array(Tu);
data1v = table2array(Tv);
t=1:1:1000;

figure(1)
subplot(2,2,1)
plot(t,data1x(:,1:4),'LineWidth',2)
legend('\alpha_1', '\alpha_2','\alpha_3','\alpha_4');
xlabel('Time (day)');
ylabel('PRCC-X')
set(gca, 'FontWeight', 'bold');

subplot(2,2,2)
plot(t,data1y(:,1:4),'LineWidth',2)
legend('\alpha_1', '\alpha_2','\alpha_3','\alpha_4');
xlabel('Time (day)');
ylabel('PRCC-Y')
set(gca, 'FontWeight', 'bold');

subplot(2,2,3)
plot(t,data1u(:,1:4),'LineWidth',2)
legend('\alpha_1', '\alpha_2','\alpha_3','\alpha_4');
xlabel('Time (day)');
ylabel('PRCC-U')
set(gca, 'FontWeight', 'bold');

subplot(2,2,4)
plot(t,data1v(:,1:4),'LineWidth',2)
legend('\alpha_1', '\alpha_2','\alpha_3','\alpha_4');
xlabel('Time (day)');
ylabel('PRCC-V')
set(gca, 'FontWeight', 'bold');

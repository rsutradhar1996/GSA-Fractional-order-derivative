%% Load data from Excel
Tx = readtable('prcc_value_collect_x.xlsx');
Ty = readtable('prcc_value_collect_y.xlsx');
Tu = readtable('prcc_value_collect_u.xlsx');
Tv = readtable('prcc_value_collect_v.xlsx');

% Convert tables to arrays
data1x = table2array(Tx);
data1y = table2array(Ty);
data1u = table2array(Tu);
data1v = table2array(Tv);

% Select the row index to plot
rowIdx = 800;

% Combine PRCC values (X, Y, U, V)
dataBlocks = [
    data1x(rowIdx,1:4);  % X
    data1y(rowIdx,1:4);  % Y
    data1u(rowIdx,1:4);  % U
    data1v(rowIdx,1:4);  % V
];

% Transpose so rows = alpha_1 to alpha_4, columns = variables
dataTransposed = dataBlocks';

% Variable (axis) labels
varLabels = {'X', 'Y', 'U', 'V'};

% Define line colors (one for each alpha)
colors = lines(4);  % MATLAB's "lines" colormap gives distinguishable colors

% Plot each line individually to apply custom colors
figure;
box on
hold on;
for i = 1:4
    plot(dataTransposed(i,:), '-o', 'LineWidth', 2, ...
        'Color', colors(i,:), 'DisplayName', ['\alpha_' num2str(i)]);
end
hold off;

% Customize axes
set(gca, 'XTick', 1:4, 'XTickLabel', varLabels, 'FontSize', 10,'FontWeight', 'bold');
xlabel('Variables');
ylabel('PRCC Value');
title('Parallel Coordinate Plot of PRCC Values');
legend('Location', 'best');
grid on;

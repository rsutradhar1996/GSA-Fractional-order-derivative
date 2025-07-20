clear;
clc;
close all;

rowIdx          = 800;
addOneShift     = true;
nGrid           = 5;
showDots        = true;
fillOpacity     = 0.50;
axesLabels      = {'X','Y','U','V'};
colors          = parula(4);

%% Load data from Excel
Tx = readtable('prcc_value_collect_x.xlsx');
Ty = readtable('prcc_value_collect_y.xlsx');
Tu = readtable('prcc_value_collect_u.xlsx');
Tv = readtable('prcc_value_collect_v.xlsx');

data1x = table2array(Tx);
data1y = table2array(Ty);
data1u = table2array(Tu);
data1v = table2array(Tv);

shift = addOneShift;

% Combine data: rows = variables (X, Y, U, V), columns = alpha_1 ... alpha_4
dataBlocks = [
    data1x(rowIdx,1:4) + shift;
    data1y(rowIdx,1:4) + shift;
    data1u(rowIdx,1:4) + shift;
    data1v(rowIdx,1:4) + shift
];

% Compute angles
nAxes  = 4;
theta  = linspace(0, 2*pi, nAxes+1);
theta(end) = theta(1);

% Subfigure captions
captions = {
    '(a) PRCC values of \alpha_1', ...
    '(b) PRCC values of \alpha_2', ...
    '(c) PRCC values of \alpha_3', ...
    '(d) PRCC values of \alpha_4'};

figure('Color','w','Position',[100 100 900 700]);

% Plot each column (alpha_1 to alpha_4)
for b = 1:4
    ax = subplot(2,2,b);  cla(ax);  hold(ax,'on');  axis(ax,'equal');  axis(ax,'off');

    % Extract PRCC values for alpha_b from all 4 variables
    curr = dataBlocks(:, b)';  % Row vector [X Y U V]
    maxVal = max(curr);

    % Concentric circular grid
    for r = linspace(0.2,1,nGrid)
        ang = linspace(0,2*pi,360);
        plot(ax, r*cos(ang), r*sin(ang), 'k-', 'LineWidth', 0.35);
        text(ax, 0, r, sprintf('%.2f', r*maxVal), ...
            'HorizontalAlignment', 'right', 'FontWeight', 'bold', 'FontSize', 10, 'Color', [0.3 0.3 0.3]);
    end

    % Axis spokes & labels
    for k = 1:nAxes
        plot(ax, [0 cos(theta(k))], [0 sin(theta(k))], 'k-', 'LineWidth', 0.5);
        text(ax, 1.18*cos(theta(k)), 1.18*sin(theta(k)), axesLabels{k}, ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 10);
    end

    % Radar polygon
    r = [curr curr(1)] / maxVal;
    x = r .* cos(theta);
    y = r .* sin(theta);

    fill(ax, x, y, colors(b,:), 'FaceAlpha', fillOpacity, ...
        'EdgeColor', colors(b,:), 'LineWidth', 1.3);

    if showDots
        plot(ax, x, y, 'o', 'MarkerFaceColor', colors(b,:), ...
            'MarkerEdgeColor', 'k', 'MarkerSize', 4);
    end

    % Caption below subplot
    pos = get(ax, 'Position');  % left bottom width height
    capX = pos(1) + pos(3)/2;   % horizontal center of subplot
    capY = pos(2) - 0.08;       % slightly below the subplot
    annotation('textbox', [capX-0.15, capY, 0.30, 0.04], ...
        'String', captions{b}, ...
        'Units', 'normalized', ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'top', ...
        'EdgeColor', 'none', ...
        'FontWeight', 'bold', ...
        'FontSize', 10);
end

sgtitle(sprintf('Radar plots of PRCC values'), 'FontSize', 10,'FontWeight', 'bold');

% Label Definitions
yLabels = {'X', 'Y', 'U', 'V'};
xLabels = {'\alpha_1','\alpha_2','\alpha_3','\alpha_4'};
numX = numel(xLabels);
numY = numel(yLabels);

% Subfigure captions
captions = {
    '(a) PRCC values at time point t = 200', ...
    '(b) PRCC values at time point t = 400', ...
    '(c) PRCC values at time point t = 600', ...
    '(d) PRCC values at time point t = 800'};

% Load PRCC data
Tx = readtable('prcc_value_collect_x.xlsx');
Ty = readtable('prcc_value_collect_y.xlsx');
Tu = readtable('prcc_value_collect_u.xlsx');
Tv = readtable('prcc_value_collect_v.xlsx');
data1x = table2array(Tx);
data1y = table2array(Ty);
data1u = table2array(Tu);
data1v = table2array(Tv);



% Plot Setup
figure(1); clf;
fig = 1;

% Choose consistent colormap
cmap = parula;            % <- Set to 'jet' or 'parula'
colormap(cmap);
nColors = size(cmap, 1);

% Loop through time points
for m = 200:200:800
    pointn = m;
    data = [data1x(pointn,1:4);
            data1y(pointn,1:4);
            data1u(pointn,1:4);
            data1v(pointn,1:4)];

    minVal = min(data(:));
    maxVal = max(data(:));
    normData = (data - minVal) / (maxVal - minVal + eps);  % For color
    sizeScale = sqrt(normData);  % Square-root scaling

    ax = subplot(2,2,fig);
    hold on;
    axis equal;
    axis off;

    cellSize = 1;
    padding = 0.15;        % spacing around glyphs
    minGlyphRatio = 0.2;   % minimum visible size (fraction of max)

    % Draw rectangles (glyphs)
    for i = 1:size(data, 1)
        for j = 1:size(data, 2)
            value = data(i, j);
            valNorm = normData(i, j);
            sizeNorm = sizeScale(i, j);
            sizeNorm = max(sizeNorm, minGlyphRatio);

            % Map value to color
            colorIdx = round(valNorm * (nColors - 1)) + 1;
            fillColor = cmap(colorIdx, :);

            % Size and position
            glyphSize = (cellSize - padding) * sizeNorm;
            x = j - 1 + (cellSize - glyphSize) / 2;
            y = size(data, 1) - i + (cellSize - glyphSize) / 2;

            rectangle('Position', [x, y, glyphSize, glyphSize], ...
                      'FaceColor', fillColor, ...
                      'EdgeColor', 'none');

            % Text overlay
            cx = j - 0.5;
            cy = size(data, 1) - i + 0.5;
            text(cx, cy, num2str(value, '%.4f'), ...
                 'HorizontalAlignment', 'center', ...
                 'VerticalAlignment', 'middle', ...
                 'FontWeight', 'bold', ...
                 'FontSize', 9, ...
                 'Color', 'k');
        end
    end

    % Axis Labels
    for j = 1:length(xLabels)
        x = j - 0.5;
        y = size(data, 1) + 0.3;
        text(x, y, xLabels{j}, ...
             'HorizontalAlignment', 'center', ...
             'FontWeight', 'bold');
    end

    for i = 1:length(yLabels)
        x = -0.3;
        y = size(data, 1) - i + 0.5;
        text(x, y, yLabels{i}, ...
             'HorizontalAlignment', 'right', ...
             'FontWeight', 'bold');
    end

    % Colorbar
    caxis([minVal maxVal])
    colorbar;

    % Caption below subplot
    pos = get(ax, 'Position');
    xMid = pos(1) + pos(3)/2;
    yBot = pos(2) - 0.05;
    annotation('textbox', [xMid-0.15, yBot, 0.3, 0.03], ...
        'String', captions{fig}, ...
        'HorizontalAlignment', 'center', ...
        'EdgeColor', 'none', ...
        'FontWeight', 'bold', ...
        'FontSize', 10);

    fig = fig + 1;
end

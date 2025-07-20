function [Prcc_value, P_value, p1, p2] = PRCC_Cal_Hex_Plot(X, Y, s, PRCC_var, y_var)
%% PRCC_Cal_Plot1
% Computes PRCC values and shows residuals using hexagonal binning plots.
%
% Inputs:
%   X         - N x k matrix of input parameters
%   Y         - T x N matrix of model outputs
%   s         - Index of time point (1 ≤ s ≤ T)
%   PRCC_var  - Cell array of parameter names
%   y_var     - String or cell array (single output name)
%
% Outputs:
%   Prcc_value - Vector of PRCC values
%   P_value    - Vector of p-values
%   p1, p2     - Last residuals used (for inspection)

% Get output at specified time point
Y = Y(s, :);
[a, k] = size(X);

% Rank transform
Xranked = rankingN(X);
Yranked = ranking1(Y);

% Compute residuals
resY = cell(1, k);
resX = cell(1, k);
for i = 1:k
    tempX = Xranked;
    tempX(:, i) = [];
    Z = [ones(a, 1), tempX];
    [~, ~, resY{i}] = regress(Yranked, Z);
    [~, ~, resX{i}] = regress(Xranked(:, i), Z);
end

% Initialize outputs
Prcc_value = zeros(1, k);
P_value = zeros(1, k);

% Plot hexbin residuals
figure(1); clf;
rows = ceil(sqrt(k-1));
cols = ceil((k-1)/rows);
hexRadius = 30.5;

for i = 1:k-1
    rY = resY{i};
    rX = resX{i};
    [r, p] = corr(rY, rX);

    Prcc_value(i) = round(r, 4);
    P_value(i) = round(p, 10);

    subplot(rows, cols, i); hold on;

    % ---- Hexbin plot starts here ----
    dx = 3/2 * hexRadius;
    dy = sqrt(3) * hexRadius;

    x = rX;
    y = rY;
    xMin = min(x); xMax = max(x);
    yMin = min(y); yMax = max(y);
    xCenters = xMin:dx:xMax;
    yCenters = yMin:dy:yMax;

    hexX = [];
    hexY = [];
    counts = [];

    for xi = 1:length(xCenters)
        for yj = 1:length(yCenters)
            x0 = xCenters(xi);
            y0 = yCenters(yj);
            if mod(xi, 2) == 0
                y0 = y0 + dy / 2;
            end
            dist = sqrt((x - x0).^2 + (y - y0).^2);
            inHex = dist < hexRadius;
            if any(inHex)
                hexX(end+1) = x0;
                hexY(end+1) = y0;
                counts(end+1) = sum(inHex);
            end
        end
    end

    theta = linspace(0, 2*pi, 7);
    for khex = 1:length(hexX)
        fill(hexX(khex) + hexRadius * cos(theta), ...
             hexY(khex) + hexRadius * sin(theta), ...
             counts(khex), 'EdgeColor', 'k');
    end
    % ---- Hexbin plot ends here ----

    axis equal;
    box on;
    %colormap hot;
    %colormap parula;%x
    %colormap cool
    %colormap spring
    %colormap summer
    %colormap autumn
    colormap winter %y
    %colormap jet %u
    %colormap hsv %y
    colorbar;


    %title([PRCC_var{i} ' [PRCC=' num2str(r, '%.2f') ', p=' num2str(p, '%.1e') ']']);
    title([' PRCC=' num2str(r, '%.2f') ]);
    xlabel(PRCC_var{i});
    if iscell(y_var)
        ylabel(y_var{1});
    else
        ylabel(y_var);
    end
set(gca, 'FontWeight', 'bold')
    p1 = rY;
    p2 = rX;
end

end

%% Helper function: ranking1
function [r, i] = ranking1(x)
n = length(x);
[s, i] = sort(x);
r = zeros(n, 1);
r(i) = (1:n)';
end

%% Helper function: rankingN
function [r,i] = rankingN(x)
[a, b] = size(x);
r = zeros(a, b);
for j = 1:b
    [~, idx] = sort(x(:, j));
    r(idx, j) = (1:a)';
end
end

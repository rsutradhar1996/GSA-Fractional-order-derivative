function [Prcc_value, P_value, p1, p2] = PRCC_Cal_Scatter_Plot(LHSM, OUTY, s, PRCC_var, y_var)
%% PRCC_Cal_Plot
% Computes and plots the Partial Rank Correlation Coefficient (PRCC)
% between input parameters and model outputs at a specific time point.
%
% Inputs:
%   LHSM         - N x k matrix of input parameters (LHS matrix)
%   OUTY         - T x N matrix of model outputs
%   s         - Scalar index of the time point to use (1 ≤ s ≤ T)
%   PRCC_var  - Cell array of strings: names of varied input parameters
%   y_var     - Cell array of strings: names of model outputs
%
% Outputs:
%   Prcc_value - Vector of PRCC values
%   P_value    - Vector of associated p-values
%   p1, p2     - Last pair of residuals used in plotting (for reference)
%
% By Simeone Marino, June 5 2007
% Modified by Marissa Renardy and Paul Wolberg, June 8, 2022
% Integrated by ChatGPT, July 2025

% Extract output at selected time point
OUTY = OUTY(s, :);

% Dimensions
[a, k] = size(LHSM);

% Rank transform of input and output
Xranked = rankingN(LHSM);
Yranked = ranking1(OUTY);

% Create residuals from regression excluding each parameter
Z = cell(1, k);
resY = cell(1, k);
resX = cell(1, k);

for i = 1:k
    tempX = Xranked;
    tempX(:, i) = [];
    Z{i} = [ones(a, 1), tempX];
    
    % Residuals from regressing ranked Y on Z{i}
    [~, ~, resY{i}] = regress(Yranked, Z{i});
    
    % Residuals from regressing ranked Xi on Z{i}
    [~, ~, resX{i}] = regress(Xranked(:, i), Z{i});
end

% Initialize outputs
Prcc_value = zeros(1, k);
P_value = zeros(1, k);

% Plot residuals and compute PRCC
figure(1);
for i = 1:k-1
    rY = resY{i};
    rX = resX{i};
    [r, p] = corr(rY, rX);

    Prcc_value(i) = round(r, 4);
    P_value(i) = round(p, 10);

    subplot(1, 4, i);
    plot(rY, rX, 'g.');
    %title(['[PRCC, p-value] = [' num2str(r, '%.4f') ', ' num2str(p, '%.2e') ']'],'FontSize', 10);
    title(['PRCC = ' num2str(r, '%.4f') ],'FontSize', 10);
    xlabel(PRCC_var{i});
    ylabel(y_var);
    set(gca, 'FontWeight', 'bold')
    %figure(2)
%     subplot(2,2,i)
%     hexbin_plot(rY,rX,0.02)
    % Store for output
    p1 = rY;
    p2 = rX;
end

end

%% Helper function: ranking1
function [r, i] = ranking1(x)
% Ranking of a vector
n = length(x);
[s, i] = sort(x);
r = zeros(n, 1);
r(i) = (1:n)';
end

%% Helper function: rankingN
function [r, i] = rankingN(x)
% Ranking of a matrix column-wise
[a, b] = size(x);
r = zeros(a, b);
for j = 1:b
    [~, i] = sort(x(:, j));
    r(i, j) = (1:a)';
end
end

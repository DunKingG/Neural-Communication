function [fitresult, gof,h] = createFit(last_x, last_y)
%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( last_x, last_y );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.9999999999999;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
% Plot fit with data.
h = plot( fitresult, xData, yData);
%set(h, 'Color', [231,127,136]/255, 'LineWidth', 3);  % 设置颜色和线宽
set(h, 'Color', [231,127,136]/255, 'LineWidth', 3);  % 设置颜色和线宽
%set(h, 'Color', double([31 108 192]/255), 'LineWidth', 2);  % 设置颜色和线宽
% Label axes
grid on


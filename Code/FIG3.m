%% 实验一：单个动作电位 采样频率10KHZ
clc ; clear all;close all;

% 指定数据文件路径
filename = 'C:\Users\DK\Desktop\Experimental data\Fig3\单个波形.txt';

%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on



% 设置导入参数
delimiterIn = '\n';
headerlinesIn = 0;

% 导入数据
A = importdata(filename, delimiterIn, headerlinesIn);

% 将数据整理成60条10000个点
% 初始化一个 10000*60 的矩阵，用于存储每10000个点的数据
resultMatrix = zeros(10000, 60);

% 按每10000个点为一组，将数据分配到不同的列中
for i = 1:60
    % 计算起始索引
    startIndex = (i - 1) * 10000 + 1;
    
    % 确保起始索引没有超出数据长度
    if startIndex > length(A)
        break;
    end
    
    % 将数据分配到结果矩阵的相应列
    resultMatrix(:, i) = A(startIndex:min(startIndex + 9999, end));
end

% 初始化一个201*60的矩阵，用于存储每条数据的最大值点及其前100个点和后100个点
finalResultMatrix = zeros(100, 60);

% 遍历每条数据，找到最大值点及其前29个点和后70个点
for i = 1:60
    % 获取当前列的数据
    currentData = resultMatrix(:, i);
    
    % 找到最大值及其索引
    [minValue, maxIndex] = max(currentData);
    
    % 计算起始和结束索引
    startIndex = max(1, maxIndex - 29);
    endIndex = min(length(currentData), maxIndex + 70);
    
    % 提取所需的100个点
    tempData = currentData(startIndex:endIndex);
    
    % 如果数据不足100个点，则填充0
    if length(tempData) < 100
        tempData = [tempData; zeros(100 - length(tempData), 1)];
    end
    
    % 将提取的数据存储到最终结果矩阵中
    finalResultMatrix(:, i) = tempData;
end

% 将结果矩阵写入Excel文件
resultExcelFileName = 'C:\Users\DK\Desktop\实验\ProcessedData.xlsx';

% 写入Excel前，先删除已有的文件
if exist(resultExcelFileName, 'file') == 2
    delete(resultExcelFileName);
end

% 写入数据到Excel文件
xlswrite(resultExcelFileName, finalResultMatrix);

% 画散点(顶端对齐的作图)
scatterHandles = gobjects(size(finalResultMatrix, 2), 1);

    % 画散点(顶端对齐的作图)
for i = 1:20
    % 横坐标：序号/10000
    x = (1:size(finalResultMatrix, 1)) / 10;
    % 纵坐标：数据点的数值
    y = finalResultMatrix(:, i);
    % 绘制数据点，使用hold on保持在同一张图上
     scatterHandles(i)=scatter(x, y, '.', 'DisplayName', strcat('Data ', num2str(i)));
    % 添加图例
    hold on;
end
meanY = mean(finalResultMatrix, 2);


% 绘制平滑样条拟合曲线
[fitresult, gof, fitHandle] = createFit(x, meanY);


% 计算上移0.5和下移0.5的曲线
upperY = meanY + 0.05;
lowerY = meanY - 0.05;

upperY = meanY + (1/6 * meanY);
lowerY = meanY - (1/6 * meanY);

% 绘制阴影区域
fill([x, fliplr(x)], [upperY', fliplr(lowerY')], [247,172,177]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

% 设置图形属性
hXLabel =xlabel('Time (ms)');
hYLabel =ylabel('CAPs (mv)');
hTitle=title('CAPs Signal');
%legend show; % 显示图例
ylim([-0.45, 0.3]);
% 保持图形窗口打开
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
box on

  
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 22)
set([hTitle, hXLabel, hYLabel], 'FontSize', 22, 'FontWeight' , 'bold')
% Legend
hLegend = legend([scatterHandles(1),fitHandle(2)], ...
                'Data1','Fit1', ...
                'Location', 'northeast',...
                 'NumColumns',2);

set(hLegend, 'FontSize', 18, 'FontWeight', 'bold'); % 设置图例框中的字体大小为 6
set(gcf, 'Color', [1 1 1]);
 % 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'CAPs';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



%% 实验一 sEMG
clc; clear;
% sEMG
delimiterIn = '\n';
headerlinesIn = 0;

filename = 'C:\Users\DK\Desktop\Experimental data\Fig3\三通道自动刺激强度\三通道自动刺激强度-sEMG.txt';

%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

% 设置导入参数
x2 = importdata(filename, delimiterIn, headerlinesIn);

% 选取数据点个数
num_points = 400000;
x2 = x2(1:num_points);

% 取第293200个点到293400个点
x22 = x2(293200:293400);
Fs = 10000; % 采样率
T = 1 / Fs; % 采样间隔
L = length(x2); % 脉冲数量
t = (0:L-1) * T; % 时间向量
% 小图时间
L = length(x22); % 脉冲数量
t0 = 29.32 + (0:L-1) * T; % 时间向量
t0 = ( t0- 29.32)*1000;

% 绘制sEMG信号
%figure;
% 计算上下1/4区域的曲线
upper_curve = x22 + (1/10) * max(abs(x22));
lower_curve = x22 - (1/10) * max(abs(x22));

% 绘制阴影区域
fill([t0, fliplr(t0)], [upper_curve', fliplr(lower_curve')], [217,198,213]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
hold on
num_simulations = 3;
scatterHandles = gobjects(num_simulations, 1);
for i = 1:num_simulations
    noisy_x22 = x22 + randn(size(x22)) * 0.5; % 添加高斯噪声
    scatterHandles(i) = scatter(t0, noisy_x22, '.','MarkerFaceAlpha', 0.01, 'MarkerEdgeAlpha', 0.01);
    hold on;
end

fitHandle=plot(t0, x22, 'linewidth', 3, 'color', double([190,116,153] / 255));

set(gca, 'ylim', [-5, 22], 'FontName', 'Arial', 'FontSize', 22, 'FontWeight', 'bold');
 
set(gca, 'LineWidth', 1);
%set(gca, 'xtick', [], 'ytick', []); % 移除坐标轴刻度值

hXLabel=xlabel('Time (ms)');
hYLabel=ylabel('sEMG (mV)');
hTitle=title('sEMG Signal');
%legend('sEMG Signal', 'Fitted Curve', 'Location', 'Best');
box on;
%hold off;
 % 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 22)
set([hTitle, hXLabel, hYLabel], 'FontSize', 22, 'FontWeight' , 'bold')
   
% Legend
hLegend = legend([scatterHandles(1),fitHandle], ...
                'Data1','Fit1', ...
                'Location', 'northeast',...
                 'NumColumns',2);


set(hLegend, 'FontSize', 20, 'FontWeight', 'bold'); % 设置图例框中的字体大小为 6
set(gcf, 'Color', [1 1 1]);

grid on
 % 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'sEMG';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');


%% 实验一 Tension
clc; clear;
% sEMG
delimiterIn = '\n';
headerlinesIn = 0;
Fs = 10000; % 采样率
T = 1 / Fs; % 采样间隔
filename = 'C:\Users\DK\Desktop\Experimental data\Fig3\三通道自动刺激强度\三通道自动刺激强度-tension.txt';


%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on



% 设置导入参数
x3 = importdata(filename, delimiterIn, headerlinesIn);

% 选取数据点个数
num_points = 400000;
x3 = x3(1:num_points);

sigmoid1 = @(x) 1./(1+exp((-x+10)*1))*5+3;
% 创建一些示例数据
x_2 = 0.2:0.01:40;
y_2 = sigmoid1(x_2);

% 取第285000个点到300000个点
x33 = x3(287000:306000);
L = length(x33); % 脉冲数量
t0 = (0:L-1) * T;
% 绘制sEMG信号
%figure;
% 计算上下1/4区域的曲线
upper_curve = x33 + (1/20) * max(abs(x33));
lower_curve = x33 - (1/20) * max(abs(x33));
num_simulations = 3;
scatterHandles = gobjects(num_simulations, 1);
sampling_rate = 100; % 选择采样率，例如每10个点取一个

for i = 1:num_simulations
    noisy_x33 = x33 + randn(size(x33)) * 0.2; % 添加高斯噪声
    sampled_x33 = noisy_x33(1:sampling_rate:end); % 进行采样
    sampled_t0 = t0(1:sampling_rate:end); % 对应的时间向量也进行采样
    scatterHandles(i) = scatter(sampled_t0, sampled_x33, '.', 'MarkerFaceAlpha', 0.1, 'MarkerEdgeAlpha', 0.1);
    hold on;
end

% 绘制阴影区域
fill([t0, fliplr(t0)], [upper_curve', fliplr(lower_curve')], [197,225,223]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
hold on
fitHandle=plot(t0,x33,'linewidth',3,'color',double([57,154,147]/255));
set(gca,'xlim',[0,1.9],'XTick', 0:0.6:1.9,'ylim',[1,9],'FontName','Arial','FontSize',14,'FontWeight','bold');
set(gca, 'LineWidth', 1);
hXLabel=xlabel('Time (s)');
hYLabel=ylabel('Tension (g)');
hTitle=title('Tension Signal ');

box on;

set(gca, 'FontName', 'Arial', 'FontSize', 22)
set([hTitle, hXLabel, hYLabel], 'FontSize', 22, 'FontWeight' , 'bold')
   

% Legend
hLegend = legend([scatterHandles(1),fitHandle], ...
                'Data1','Fit1', ...
                'Location', 'northeast',...
                 'NumColumns',2);


set(hLegend, 'FontSize', 18, 'FontWeight', 'bold'); % 设置图例框中的字体大小为 6
set(gcf, 'Color', [1 1 1]);
grid on


 % 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'Tension';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');




%% 实验二：神经干传导速度
% A通道
clc; clear;

%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

subplot(2,1,1);
A = xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\传导速度\A通道（前）\A1.csv');
% 初始化一个50*10的矩阵，用于存储每条数据的最小值点及其前10个点和后39个点
finalResultMatrix = zeros(50, size(A, 2));

% 遍历每条数据，找到最小值点及其前10个点和后39个点
for i = 1:size(A, 2)
    % 获取当前列的数据
    currentData = A(:, i);
    % 找到最小值及其索引
    [minValue, minIndex] = min(currentData);
    % 计算起始和结束索引
    startIndex = max(1, minIndex - 5);
    endIndex = min(length(currentData), minIndex + 44);
    % 提取所需的数据段
    tempData = currentData(startIndex:endIndex);
    % 如果提取的数据不足50个点，则在前面或后面填充与最后一个值相同的数值
    if length(tempData) < 50
        if startIndex > 1
            % 在前面填充与第一个值相同的数值
            tempData = [repmat(tempData(1), max(0, 50 - length(tempData)), 1); tempData];
        else
            % 在后面填充与最后一个值相同的数值
            tempData = [tempData; repmat(tempData(end), max(0, 50 - length(tempData)), 1)];
        end
    end
    
    % 将提取的数据存储到最终结果矩阵中，确保最小值点对齐
    finalResultMatrix(:, i) = tempData;
end


% 画散点(顶端对齐的作图)
scatterHandles = gobjects(size(finalResultMatrix, 2), 1);

% 画散点图
for i = 1:size(finalResultMatrix, 2)
    % 横坐标：序号/5
    x = (1:50) / 10;
    % 纵坐标：数据点的数值
    y = finalResultMatrix(:, i);
    
    % 绘制数据点
    hold on
     scatterHandles(i)=scatter(x, y, '.', 'DisplayName', strcat('Data ', num2str(i)));
end

meanY = mean(finalResultMatrix, 2);
% 绘制平滑样条拟合曲线
[fitresult, gof, fitHandle] = createFit(x, meanY);


upperY = meanY + (1/3 * meanY);
lowerY = meanY - (1/3 * meanY);

% 绘制阴影区域
fill([x, fliplr(x)], [upperY', fliplr(lowerY')], [247,172,177]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

% 设置图形属性
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
hXLabel =xlabel('Time (ms)', 'FontName', 'Arial', 'FontSize', 22);
hYLabel =ylabel('CAPs (mV)', 'FontName', 'Arial', 'FontSize', 22);
box on;
xlim([0, 5]);
ylim([-0.5, 0.25]);
%hold on;

% 设置图形属性

hTitle=title('CAPs-1');
%legend show; % 显示图例

% 保持图形窗口打开
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
box on

 
    % 字体和字号
    set(gca, 'FontName', 'Arial', 'FontSize', 12)
    set([hTitle, hXLabel, hYLabel], 'FontSize', 20, 'FontWeight' , 'bold')
   


% Legend
hLegend = legend([scatterHandles(1),fitHandle(2)], ...
                'Data1','Fit1', ...
                'Location', 'southeast',...
                 'NumColumns',2);

set(hLegend, 'FontSize', 18, 'FontWeight', 'bold'); % 设置图例框中的字体大小为 6
set(gcf, 'Color', [1 1 1]);



% B通道
% 读取数据
B = xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\传导速度\B通道（后）\B2.csv');

% 初始化一个50*10的矩阵，用于存储每条数据的最大值点及其前30个点和后19个点
finalResultMatrix = zeros(50, size(B, 2));

% 子图设置
subplot(2,1,2);

% 遍历每条数据，找到最大值点及其前30个点和后19个点
for i = 1:size(B, 2)
    % 获取当前列的数据
    currentData = B(:, i);
    
    % 找到最大值及其索引
    [maxValue, maxIndex] = max(currentData);
    
    % 计算起始和结束索引
    startIndex = max(1, maxIndex - 30);
    endIndex = min(size(currentData, 1), maxIndex + 19); % 需要+1以包含最大值点后20个点
    
    % 提取所需的数据段
    tempData = currentData(startIndex:endIndex);
    
    % 如果提取的数据不足50个点，则在前面或后面填充与最后一个值相同的数值
    if length(tempData) < 50
        % 在后面填充与最后一个值相同的数值，直到长度达到50
        tempData = [tempData; repmat(tempData(end), 50 - length(tempData), 1)];
    end
    
    % 将提取的数据存储到最终结果矩阵中，确保最大值点对齐
    finalResultMatrix(:, i) = tempData(end-49:end); % 取最后50个数据点
end

% 画散点图
hold on;

% 画散点(顶端对齐的作图)
scatterHandle = gobjects(size(finalResultMatrix, 2), 1);

for i = 1:size(finalResultMatrix, 2)
    % 横坐标：序号/10
    x = (1:50) / 10;
    % 纵坐标：数据点的数值
    y = finalResultMatrix(:, i);
    
    % 绘制数据点
    scatterHandle(i)=scatter(x, y, '.', 'DisplayName', strcat('Data ', num2str(i)));
end

% 计算每列的平均值
meanY = mean(finalResultMatrix, 2);

% 绘制平滑样条拟合曲线
[fitresult1, gof1, fitHandle1] = createFit(x, meanY);

upperY = meanY + (1/3 * meanY);
lowerY = meanY - (1/3 * meanY);

% 绘制阴影区域
fill([x, fliplr(x)], [upperY', fliplr(lowerY')], [247,172,177]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

% 设置图形属性
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
hXLabel=xlabel('Time (ms)', 'FontName', 'Arial', 'FontSize', 12);
hYLabel=ylabel('CAPs (mV)', 'FontName', 'Arial', 'FontSize', 12);
box on;

% 坐标轴刻度调整
    set(gca, 'YLim',[-0.5 0.5],'YTick', -0.5:0.2:0.5)

hTitle=title('CAPs-2');
% 保持图形窗口打开
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
box on
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 12)
set([hTitle, hXLabel, hYLabel], 'FontSize', 20, 'FontWeight' , 'bold')
   
% Legend
hLegend = legend([scatterHandle(1),fitHandle1(2)], ...
                'Data2','Fit2', ...
                'Location', 'southeast',...
                 'NumColumns',2);

set(hLegend, 'FontSize', 18, 'FontWeight', 'bold'); % 设置图例框中的字体大小为 6
set(gcf, 'Color', [1 1 1]);


 % 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '传导速度';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');


%% 实验三：不应期实验
clc;clear
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\不应期\1ms\1ms.csv');
timespan = linspace(1,length(A(:,1)),length(A(:,1)));

%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 18;
figureHeight = 8;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on


subplot(2,3,6);
for i=1:3 
    L=A(:,i);
    xi=1:1/2:length(A(:,1));
    yi=interp1(timespan,L,xi, 'spline');
    plot(timespan/10,L,'.',xi/10,yi,'.','MarkerSize', 5);
    hold on
end
L=A(:,2);
plot(timespan/10,L,'-','color',double([231,127,136]/255),'linewidth',2);
set(gca,'color','none','linewidth',1)
set(gca,'FontName','Arial','FontSize',12,'FontWeight','bold');
xlabel('Time (ms)','fontname','Arial','FontSize',12);
ylabel('CAPs (mV)','fontname','Arial','fontsize',12);
ylim([-1 1.5]);
% 坐标轴刻度调整
%set(gca, 'YLim',[-1 1.5],'YTick', -1:0.5:1.5)
title(' Time Interval: 1ms','FontSize', 12,'FontWeight','bold');
set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % 小刻度
box on

% 1.5ms不应期实验
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\不应期\1.5ms\1.5ms.csv');
timespan = linspace(1,length(A(:,1)),length(A(:,1)));
subplot(2,3,5);
for i=1:3
    L=A(:,i);
    xi=1:1/2:length(A(:,1));
    yi=interp1(timespan,L,xi, 'spline');
    plot(timespan/10,L,'.',xi/10,yi,'.','MarkerSize', 5);
    hold on
end
L=A(:,2);
plot(timespan/10,L,'-','color',double([231,127,136]/255),'linewidth',2);
set(gca,'color','none','linewidth',1)
set(gca,'FontName','Arial','FontSize',12,'FontWeight','bold');
xlabel('Time (ms)','fontname','Arial','FontSize',12);
ylabel('CAPs (mV)','fontname','Arial','fontsize',12);
ylim([-1 1.5]);
title(' Time Interval: 1.5ms','FontSize', 12,'FontWeight','bold');
 set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % 小刻度
box on



% 2ms不应期实验
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\不应期\2ms\2ms.csv');
timespan = linspace(1,length(A(:,1)),length(A(:,1)));
subplot(2,3,4);
for i=1:3
    L=A(:,i);
    xi=1:1/2:length(A(:,1));
    yi=interp1(timespan,L,xi, 'spline');
    plot(timespan/10,L,'.',xi/10,yi,'.','MarkerSize', 5);
    hold on
end
L=A(:,2);
plot(timespan/10,L,'-','color',double([231,127,136]/255),'linewidth',2);
set(gca,'color','none','linewidth',1)
set(gca,'FontName','Arial','FontSize',12,'FontWeight','bold');
xlabel('Time (ms)','fontname','Arial','FontSize',12);
ylabel('CAPs (mV)','fontname','Arial','fontsize',12);
ylim([-1 1.5]);
title(' Time Interval: 2ms','FontSize', 12,'FontWeight','bold');
 set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % 小刻度
box on
% 3ms不应期实验
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\不应期\3ms\3ms.csv');
timespan = linspace(1,length(A(:,1)),length(A(:,1)));
subplot(2,3,3);
for i=1:3
    L=A(:,i);
    xi=1:1/2:length(A(:,1));
    yi=interp1(timespan,L,xi, 'spline');
    plot(timespan/10,L,'.',xi/10,yi,'.','MarkerSize', 5);
    hold on
end
L=A(:,2);
plot(timespan/10,L,'-','color',double([231,127,136]/255),'linewidth',2);
set(gca,'color','none','linewidth',1)
set(gca,'FontName','Arial','FontSize',12,'FontWeight','bold');
xlabel('Time (ms)','fontname','Arial','FontSize',12);
ylabel('CAPs (mV)','fontname','Arial','fontsize',12);
ylim([-1 1.5]);
title(' Time Interval: 3ms','FontSize', 12,'FontWeight','bold');
 set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % 小刻度
box on
% 4ms不应期实验
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\不应期\4ms\4ms.csv');
timespan = linspace(1,length(A(:,1)),length(A(:,1)));
subplot(2,3,2);
for i=1:5
    L=A(:,i);
    xi=1:1/2:length(A(:,1));
    yi=interp1(timespan,L,xi, 'spline');
    plot(timespan/10,L,'.',xi/10,yi,'.','MarkerSize', 5);
    hold on
end
L=A(:,3);
plot(timespan/10,L,'-','color',double([231,127,136]/255),'linewidth',2);
set(gca,'color','none','linewidth',1)
set(gca,'FontName','Arial','FontSize',12,'FontWeight','bold');
xlabel('Time (ms)','fontname','Arial','FontSize',12);
ylabel('CAPs (mV)','fontname','Arial','fontsize',12);
ylim([-1 1.5]);
title(' Time Interval: 4ms','FontSize', 12,'FontWeight','bold');
 set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % 小刻度
box on   
% 5ms不应期实验
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\不应期\5ms\5ms.csv');
timespan = linspace(1,length(A(:,1)),length(A(:,1)));
subplot(2,3,1);
for i=1:3
    L=A(:,i);
    xi=1:1/2:length(A(:,1));
    yi=interp1(timespan,L,xi, 'spline');
    plot(timespan/10,L,'.',xi/10,yi,'.','MarkerSize', 5);
    hold on
end
L=A(:,1);
plot(timespan/10,L,'-','color',double([231,127,136]/255),'linewidth',2);
set(gca,'color','none','linewidth',1)
set(gca,'FontName','Arial','FontSize',12,'FontWeight','bold');
xlabel('Time (ms)','fontname','Arial','FontSize',12);
ylabel('CAPs (mV)','fontname','Arial','fontsize',12);
ylim([-1 1.5]);
title(' Time Interval: 5ms','FontSize', 12,'FontWeight','bold');
set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % 小刻度
box on  

    
% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '不应期';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



   
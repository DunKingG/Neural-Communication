%% 实验七：肌肉收缩状态下的信息传递
% 第一个图包含原始信号图和处理信号图
clc;clear;

% CAPs
filename = 'C:\Users\DK\Desktop\Experimental data\Fig5\单路信号传输\sEMG_1.2V,35Hz传0.2V,55Hz.txt';

%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

% 设置导入参数并调整采样率
delimiterIn = '\n';
headerlinesIn = 0;
x_raw = importdata(filename, delimiterIn, headerlinesIn);
%删除第28000个点到第36000个点，后面的数据自动填补进来
start_index = 28000;
end_index = 36000;
x_raw(start_index:end_index) = [];
%移动数据
num_deleted = end_index - start_index + 1;
x_raw(end-num_deleted+1:end) = [];
Fs = 10000; % 采样率
T = 1 / Fs; % 采样间隔
L = length(x_raw); % 脉冲数量
t = (0:L-1) * T; % 时间向量
%figure;

subplot(3,1,1);
plot(t,x_raw,'linewidth',0.001,'color',double([229,139,123]/255));
hTitle = title('Raw sEMG');
% 幅度处理
x=x_raw;
x(abs(x) < 0.5) = 0;
x(x < 0) = 0;
%细节优化   
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% 坐标轴刻度调整
set(gcf,'Color',[1 1 1])
set(gca,'ylim',[-4,30],'yTick',0:15:30,'xlim',[0,35],'XTick',0:5:35,'FontName','Arial','FontSize',16);


subplot(3, 1, 2);
plot(t, x_raw,'linewidth',0.1,'color',double([149,209,157]/255));
hold on
plot(t, x,'linewidth',0.001,'color',double([229,139,123]/255));
hTitle = title('Signal Rectification');


%细节优化
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
set(gca,'ylim',[-4,30],'yTick',0:15:30,'xlim',[0,35],'XTick',0:5:35,'FontName','Arial','FontSize',16);



subplot(3, 1, 3);
% 幅度处理
x(x > 0.5) = 25;
%细节优化
hYLabel = ylabel('sEMG (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')

% 坐标轴刻度调整
set(gca, 'YLim',[0 30])
set(gcf,'Color',[1 1 1])
set(gca,'ylim',[0,30],'yTick',0:15:30,'xlim',[0,35],'XTick',0:5:35,'FontName','Arial','FontSize',16);
plot(t, x,'linewidth',0.1,'color',double([149,209,157]/255));
hold on
plot(t, x_raw,'linewidth',0.001,'color',double([229,139,123]/255));
hTitle = title('Signal Calibration');
%细节优化
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% 赋色及属性调整

% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gca, 'YLim',[0 30])
set(gcf,'Color',[1 1 1])
set(gca,'ylim',[0,30],'yTick',0:15:30,'xlim',[0,35],'XTick',0:5:35,'FontName','Arial','FontSize',16);
 % 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '原始信号图和处理信号图';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



%% 单独一张图表示频域
% 时域变频域
%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on


NFFT = 2^nextpow2(L);
X = fft(x, NFFT) / L;
f = Fs / 2 * linspace(0, 1, NFFT / 2 + 1);
%figure;
% 作图
plot(f, 2 * abs(X(1:NFFT / 2 + 1)),'linewidth',2,'color',double([229,139,123]/255));
hXLabel=xlabel('Frequency (Hz)','fontname','Arial','fontsize',14);
hYLabel=ylabel('sEMG (mV) ','fontname','Arial','fontsize',14);
hTitle =title('Frequency Spectrum');
set(gca,'xlim',[0,100],'FontName','Arial','FontSize',17,'FontWeight','bold');
set(gca, 'LineWidth',1);

set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 17, 'FontWeight' , 'bold')
% 坐标区调整
    set(gca, 'Box', 'on', ...                                % 边框
        'Layer','top',...                                % 图层
       'XGrid', 'off', 'YGrid', 'on' )              % 网格


set(gca, 'XLim',[0 100],'XTick', 0:5:100,'ylim',[0,1.8],'yTick',0:0.2:1.8,'FontSize',17)


% 绘制方框
rectangle('Position',[35.6-2 0 4 1], 'EdgeColor', '#06948E', 'LineWidth', 2); % 15Hz
rectangle('Position',[71.25-2 0 4 1], 'EdgeColor', '#818689', 'LineWidth', 2); % 40Hz
rectangle('Position',[55.8-2 0 4 1], 'EdgeColor', '#874290', 'LineWidth', 2); % 55Hz

% 创建虚拟方框对象用于图例
h1 = plot(nan, nan, 's', 'MarkerEdgeColor', '#06948E', 'LineWidth', 2, 'MarkerSize', 10); % 蓝色方框
h2 = plot(nan, nan, 's', 'MarkerEdgeColor', '#874290', 'LineWidth', 2, 'MarkerSize', 10); % 红色方框
h3 = plot(nan, nan, 's', 'MarkerEdgeColor', '#818689', 'LineWidth', 2, 'MarkerSize', 10); % 红色方框

% 添加图例
legend([h1 h2 h3], {' Biological Signal(~35Hz) ', 'Engineered Signals(~55Hz)','Harmonic Noise(~70Hz)'}, 'FontSize', 15, 'FontWeight', 'bold');

     
% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '单独一张图表示频域';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');




%% 滤波
% 滤波器55HZ
Fpass1 = 54;
Fpass2 = 56;
d = designfilt('bandpassiir', 'FilterOrder', 2, ...
    'HalfPowerFrequency1', Fpass1, 'HalfPowerFrequency2', Fpass2, ...
    'SampleRate', Fs);

% 应用滤波器
y = filter(d, x);

% 整流
y(y < 0) = 0;


% 高斯核卷积（需要调整数据/添加比特周期的线/阈值的线）
% 定义高斯核函数
%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on
sigma = 3000; % 高斯核标准差
sz = 20000; % 核函数大小，确保核函数覆盖的范围足够大
x = linspace(-sz / 2, sz / 2, sz);
gaussianKernel = exp(-x .^ 2 / (2 * sigma ^ 2)) / (sigma * sqrt(2 * pi));

% 对信号y进行卷积
y_convolved = 4*conv(y, gaussianKernel, 'same');

% 绘制结果
%figure;
subplot(3,1,1);
plot(t, y, 'linewidth', 0.001, 'color', double([229,139,123]/255));
title('Filtered Signal');
hXLabel =xlabel('Time (s)');
hYLabel = ylabel('sEMG (mV)');
grid on;
hTitle = title('Filtered Signal');%细节优化
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% 坐标轴刻度调整
set(gca,'YLim',[0 0.8],'YTick', 0:0.4:0.8,'XLim',[0 35],'XTick', 0:5:35)
set(gcf,'Color',[1 1 1])

subplot(3,1,2);
plot(t, y, 'linewidth', 0.001, 'color', double([228,171,151]/255));
hold on
plot(t, y_convolved, 'linewidth', 2, 'color', double([190,116,153]/255));
title('Envelope Detected Signal');
set(gca,'YLim',[0 0.8],'YTick', 0:0.4:0.8,'XLim',[0 35],'XTick', 0:5:35)
hXLabel=xlabel('Time (s)');
hYLabel=ylabel('sEMG (mV)');
grid on;
hTitle = title('Envelope Detected Signal');%细节优化   
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
%hold on;

subplot(3,1,3);
plot(t, y, 'linewidth', 0.001, 'color', double([228,171,151]/255));
hold on
plot(t, y_convolved, 'linewidth', 2, 'color', double([190,116,153]/255));
title('Filtered Signal with Gaussian Convolution');
set(gca,'YLim',[0 1],'YTick', 0:0.4:0.8,'XLim',[0 35],'XTick', 0:5:35)
hXLabel=xlabel('Time (s)');
hYLabel=ylabel('sEMG (mV)');
grid on;
% 定义编码模式
code = [1 0 1 1 0 1 1 1 0 0 1 0 1];
code_length = length(code);
interval = 2;

% 添加每隔interval的分割线并填充色块
for i = 1:code_length
    % 计算当前色块的起始位置和结束位置，从x=2开始
    x_start = 2 + (i - 1) * interval;
    x_end = 2 + i * interval;
    if code(i) == 1
        % 绘制蓝色色块
        patch([x_start x_start x_end x_end], [-1 1 1 -1],[127,219,208] /255, 'FaceAlpha', 0.35, 'EdgeColor', 'none');
    end
    % 添加标注
    text((x_start + x_end) / 2, 0.9, num2str(code(i)), 'FontName', 'Arial', 'FontSize', 14, 'HorizontalAlignment', 'center','FontWeight' , 'bold');
    % 添加分割线
    xline(x_start,'--', 'color', 'k', 'LineWidth', 1);
end

% 添加最后一条分割线
xline(2 + code_length * interval, '--','color', 'k', 'LineWidth', 1);
% 添加阈值横线
yline(0.4, '--', 'Threshold',  'FontSize', 12, 'FontName', 'Arial','FontWeight' , 'bold','color', 'r', 'LineWidth', 2);
hTitle = title('Demodulated Signal');%细节优化
       
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])


% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '肌肉收缩状态下的信息传递';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



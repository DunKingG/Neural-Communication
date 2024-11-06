%% 实验八：神经通信信道复用
%EXP8

clc;clear;
% CAPs
filename = 'C:\Users\DK\Desktop\Experimental data\Fig6\sEMG_0.25V_15Hz_55Hz_40Hz.txt';

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
x_raw = importdata(filename, delimiterIn, headerlinesIn);
Fs = 10000; % 采样率
T = 1 / Fs; % 采样间隔
L = length(x_raw); % 脉冲数量
t = (0:L-1) * T; % 时间向量

%figure;
subplot(3,1,1);
plot(t,x_raw,'linewidth',0.001,'color',double([229,139,123]/255));
set(gca,'ylim',[-10,50],'xlim',[0,90],'XTick',0:10:90,'FontName','Arial','FontSize',12);
hTitle =title('Raw sEMG');
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% 坐标轴刻度调整
set(gcf,'Color',[1 1 1])
    
subplot(3, 1, 2);
% 信号标准化
x=x_raw;
x(abs(x) < 0.5) = 0;
x(x < 0) = 0;
%细节优化
%Title
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')

% 坐标轴刻度调整
set(gcf,'Color',[1 1 1])
plot(t, x_raw,'linewidth',0.001,'color',double([149,209,157]/255));
hold on
plot(t, x,'linewidth',2,'color',double([229,139,123]/255));
hTitle =title('Signal Rectification');
set(gca,'ylim',[-10,50],'xlim',[0,90],'XTick',0:10:90,'FontName','Arial','FontSize',12);
%细节优化
%Title
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG  (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% 坐标轴刻度调整
set(gca, 'YLim',[-10,50])
set(gcf,'Color',[1 1 1])

subplot(3, 1, 3);
% 信号标准化
x1=x;
x(x > 0.5) = 42;
%细节优化
%Title
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% 赋色及属性调整

% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% 坐标轴刻度调整
set(gca, 'YLim',[-10,50])
set(gcf,'Color',[1 1 1])
plot(t, x,'linewidth',0.001,'color',double([149,209,157]/255));
hold on
plot(t, x1,'linewidth',2,'color',double([229,139,123]/255));
hTitle =title('Signal Calibration');
set(gca,'ylim',[-10,50],'xlim',[0,90],'XTick',0:10:90,'FontName','Arial','FontSize',12);
%细节优化
%Title
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG  (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% 坐标轴刻度调整
set(gca, 'YLim',[-10,50])
set(gcf,'Color',[1 1 1])
% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '信道复用——原始信号图和处理信号图';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');


%% 单独一张图表示频域
%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on


% 时域变频域
NFFT = 2^nextpow2(L);
X = fft(x, NFFT) / L;
f = Fs / 2 * linspace(0, 1, NFFT / 2 + 1);

% 作图
plot(f, 2 * abs(X(1:NFFT / 2 + 1)),'linewidth',2.5,'color',double([229,139,123]/255));
hXLabel=xlabel('Frequency (Hz)','fontname','Arial','fontsize',14);
hYLabel=ylabel('sEMG (mV) ','fontname','Arial','fontsize',14);
hTitle =title('Frequency Spectrum');
set(gca,'xlim',[0,100],'FontName','Arial','FontSize',12,'FontWeight','bold');
set(gca, 'LineWidth',1);
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 17, 'FontWeight' , 'bold')
% 坐标区调整
set(gca, 'Box', 'on', ...                                % 边框
    'Layer','top',...                                % 图层
   'XGrid', 'off', 'YGrid', 'on' )              % 网格
set(gca, 'XLim',[0 100],'XTick', 0:5:100)


% 绘制方框
rectangle('Position',[15.3-2 0 4 0.2], 'EdgeColor', '#06948E', 'LineWidth', 2); % 15Hz
rectangle('Position',[40.7-2 0 4 0.2], 'EdgeColor', '#874290', 'LineWidth', 2); % 40Hz
rectangle('Position',[55.8-2 0 4 0.2], 'EdgeColor', '#874290', 'LineWidth', 2); % 55Hz

% 创建虚拟方框对象用于图例
h1 = plot(nan, nan, 's', 'MarkerEdgeColor', '#06948E', 'LineWidth', 2, 'MarkerSize', 10); % 蓝色方框
h2 = plot(nan, nan, 's', 'MarkerEdgeColor', '#874290', 'LineWidth', 2, 'MarkerSize', 10); % 红色方框

% 添加图例
legend([h1 h2], {' Biological Signal(~15Hz) ', 'Engineered Signals(~55Hz and ~40Hz)'}, 'FontSize', 14, 'FontWeight', 'bold');

% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '信道复用-单独一张图表示频域';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



%% 滤波
% 滤波器40HZ
Fpass1 = 39;
Fpass2 = 41;
d = designfilt('bandpassiir', 'FilterOrder', 2, ...
    'HalfPowerFrequency1', Fpass1, 'HalfPowerFrequency2', Fpass2, ...
    'SampleRate', Fs);

% 应用滤波器
y1 = filter(d, x);
% 整流
y1(y1 < 0) = 0;
% 滤波器55HZ
Fpass1 = 54;
Fpass2 = 56;
d = designfilt('bandpassiir', 'FilterOrder', 2, ...
    'HalfPowerFrequency1', Fpass1, 'HalfPowerFrequency2', Fpass2, ...
    'SampleRate', Fs);

% 应用滤波器
y2 = filter(d, x);
% 整流
y2(y2 < 0) = 0;
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
sigma = 5000; % 高斯核标准差
sz = 20000; % 核函数大小，确保核函数覆盖的范围足够大
x = linspace(-sz / 2, sz / 2, sz);
gaussianKernel = exp(-x .^ 2 / (2 * sigma ^ 2)) / (sigma * sqrt(2 * pi));

% 对信号y进行卷积
y1_convolved = 4*conv(y1, gaussianKernel, 'same');

% 绘制结果
%figure;
subplot(3,2,1);
plot(t, y1, 'linewidth', 0.001, 'color', double([229,139,123]/255));
hTitle =title('Filtered Signal A');
hXLabel =xlabel('Time (s)');
hYLabel =ylabel('sEMG (mV)');
grid on;
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(hYLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% 坐标轴刻度调整
set(gca, 'XLim',[0 90],'XTick', 0:30:90,'YLim',[0 0.65],'YTick', 0:0.2:0.65)



subplot(3,2,3);
plot(t, y1, 'linewidth', 0.001, 'color', double([228,171,151]/255));
hold on
plot(t, y1_convolved, 'linewidth', 2, 'color', double([190,116,153]/255));
hTitle=title('Envelope Detected Signal A');
%hTitle=xlabel('Time (s)');
hXLabel =xlabel('Time (s)');
hYLabel=ylabel('sEMG (mV)');
grid on;
 % 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 13, 'FontWeight' , 'bold')
set(hYLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
set(gca, 'XLim',[0 90],'XTick', 0:30:90,'YLim',[0 0.65],'YTick', 0:0.2:0.65)
% 对信号y进行卷积
y2_convolved = 4*conv(y2, gaussianKernel, 'same');

subplot(3,2,5);
plot(t, y1, 'linewidth', 0.001, 'color', double([228,171,151]/255));
hold on
plot(t, y1_convolved, 'linewidth', 2, 'color', double([190,116,153]/255));
hTitle=title('Demodulated Signal A');
%hTitle=xlabel('Time (s)');
hXLabel =xlabel('Time (s)');
hYLabel=ylabel('sEMG (mV)');
grid on;

% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(hYLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
set(gca, 'XLim',[0 90],'XTick', 0:30:90,'YLim',[0 0.7],'YTick', 0:0.2:0.7)


% 对信号y进行卷积
y2_convolved = 4*conv(y2, gaussianKernel, 'same');
% 定义编码模式
code = [1 1 0 0 1 1 0 0 1 1 0 1 1];
code_length = length(code);
interval = 5.9;

% 添加每隔interval的分割线并填充色块
for i = 1:code_length
    % 计算当前色块的起始位置和结束位置，从x=2开始
    x_start = 5 + (i - 1) * interval;
    x_end = 5 + i * interval;
    
    if code(i) == 1
        % 绘制蓝色色块
        patch([x_start x_start x_end x_end], [-1 1 1 -1],[127,219,208] /255, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    end
 

    % 添加标注
    text((x_start + x_end) / 2, 0.6, num2str(code(i)), 'FontName', 'Arial', 'FontSize', 12, 'HorizontalAlignment', 'center','FontWeight' , 'bold');
    
    
    % 添加分割线
    xline(x_start,'--', 'color', 'k', 'LineWidth', 1);
end

% 添加最后一条分割线
xline(5 + code_length * interval, '--','color', 'k', 'LineWidth', 1);
yline(0.4, '--', 'color', 'r', 'LineWidth', 2);




 % 绘制结果
subplot(3,2,2);
plot(t, y2, 'linewidth', 0.001, 'color', double([229,139,123]/255));
hTitle=title('Filtered Signal B');
hXLabel =xlabel('Time (s)');
grid on;
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% 坐标轴刻度调整
set(gca, 'XLim',[0 35],'XTick', 0:10:35,'YLim',[0 0.75],'YTick', 0:0.2:0.75)

subplot(3,2,4);
plot(t, y2, 'linewidth', 0.001, 'color', double([228,171,151]/255));
hold on
plot(t, y2_convolved, 'linewidth', 2, 'color', double([190,116,153]/255));
hTitle=title('Envelope Detected Signal B');
hXLabel =xlabel('Time (s)');

grid on;
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set(hXLabel, 'FontSize', 16, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 13, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% 坐标轴刻度调整
set(gca, 'XLim',[0 35],'XTick', 0:10:35,'YLim',[0 0.75],'YTick', 0:0.2:0.75)




subplot(3,2,6);
plot(t, y2, 'linewidth', 0.001, 'color', double([228,171,151]/255));
hold on
plot(t, y2_convolved, 'linewidth', 2, 'color', double([190,116,153]/255));
hTitle=title('Demodulated Signal B');
hXLabel =xlabel('Time (s)');
grid on;
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% 坐标轴刻度调整
set(gca, 'XLim',[0 35],'XTick', 0:10:35,'YLim',[0 0.85],'YTick', 0:0.2:0.85)


 % 定义编码模式
code = [1 0 1 1 0 1 1 1 0 0 1 0 1];
code_length = length(code);
interval = 2;

% 添加每隔interval的分割线并填充色块
for i = 1:code_length
    % 计算当前色块的起始位置和结束位置，从x=2开始
    x_start = 6.5 + (i - 1) * interval;
    x_end = 6.5 + i * interval;
    if code(i) == 1
        % 绘制蓝色色块
        patch([x_start x_start x_end x_end], [-1 1 1 -1],[127,219,208] /255, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    end
    % 添加标注
    text((x_start + x_end) / 2, 0.74, num2str(code(i)), 'FontName', 'Arial', 'FontSize', 12, 'HorizontalAlignment', 'center','FontWeight' , 'bold');
    % 添加分割线
    xline(x_start,'--', 'color', 'k', 'LineWidth', 1);
end

% 添加最后一条分割线
xline(6.5 + code_length * interval, '--','color', 'k', 'LineWidth', 1);
yline(0.4, '--', 'color', 'r', 'LineWidth', 2);

 % 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '信道复用';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');




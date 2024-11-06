%% 实验六：寻找合适的刺激强度
clc;clear;


%图片尺寸设置（单位：厘米）
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%窗口设置
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

% CAPs
filename = 'C:\Users\DK\Desktop\Experimental data\Fig4\三通道自动刺激强度\三通道自动刺激强度-CAPs.txt';
% 设置导入参数(总体)
delimiterIn = '\n';
headerlinesIn = 0;
% 导入数据
x1 = importdata(filename, delimiterIn, headerlinesIn);

%波形调整
x1(x1 < -0.08) = -0.08;
x1(x1 > 0.12) = 0.12;

% 创建20000个与第一个数据点数值相等的点
extra_points = repmat(x1(1), 20000, 1);

% 将额外的点加到数据的前面
x1 = [extra_points; x1];

% 选取数据点个数
num_points = 420000;
x1 = x1(1:num_points);


% 取第285000个点到300000个点
x11 = x1(293200:293400);

% 大图/小图范围总体设置
% 大图时间
Fs = 10000; % 采样率
T = 1 / Fs; % 采样间隔
L = length(x1); % 脉冲数量
t = (0:L-1) * T; % 时间向量
% 小图时间
L = length(x11); % 脉冲数量
t0 = 29.32+(0:L-1) * T; % 时间向量
% 数据拟合，从第50000个点开始找往后每20000个点中的最大值以及索引，分别保存在y_vector和x_vector中 
sigmoid1 = @(x) 1./(1+exp((-x+16)*0.15))*2.4/10-0.1;
% 创建一些示例数据
x_0 = 0:0.01:42;
y_0 = sigmoid1(x_0);



subplot(3,1,1);
plot(t/35,x1,'linewidth',1.5,'color',double([247,172,177]/255));
hold on;
plot(x_0/35, y_0, '--', 'linewidth',1.5,'color',double([247,172,177]/255));
set(gca,'ylim',[-0.12,0.15],'FontName','Arial','FontSize',12,'FontWeight','bold');
set(gca, 'LineWidth', 1);
%细节优化
hXLabel = xlabel('Stimulation (V)');
hYLabel = ylabel('CAPs (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set(hYLabel, 'FontSize', 14,'FontWeight' , 'bold')
set(hXLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% sEMG
filename = 'C:\Users\DK\Desktop\Experimental data\Fig4\三通道自动刺激强度\三通道自动刺激强度-sEMG.txt';
% 设置导入参数
x2 = importdata(filename, delimiterIn, headerlinesIn);
% 创建20000个与第一个数据点数值相等的点
extra_points = repmat(x2(1), 20000, 1);
% 将额外的点加到数据的前面
x2 = [extra_points; x2];
% 选取数据点个数
num_points = 420000;
x2 = x2(1:num_points);
% 取第285000个点到300000个点
x22 = x2(293200:293400);
sigmoid1 = @(x) 1./(1+exp((-x+15)*0.1))*20-1;
% 创建一些示例数据
x_1 = 0:0.01:42;
y_1 = sigmoid1(x_1);


subplot(3,1,2);
plot(t/35,x2,'linewidth',1.5,'color',double([190,116,153]/255));
hold on;
plot(x_1/35, y_1, '--', 'linewidth',1.5,'color',double([190,116,153]/255));
set(gca,'ylim',[-5,22],'FontName','Arial','FontSize',12,'FontWeight','bold');
set(gca, 'LineWidth', 1);
%细节优化
hXLabel = xlabel('Stimulation (V)');
hYLabel = ylabel('sEMG (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set(hYLabel, 'FontSize', 14,'FontWeight' , 'bold')
set(hXLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% 肌肉张力
filename = 'C:\Users\DK\Desktop\Experimental data\Fig4\三通道自动刺激强度\三通道自动刺激强度-tension.txt';
% 设置导入参数
x3 = importdata(filename, delimiterIn, headerlinesIn);
% 创建20000个与第一个数据点数值相等的点
extra_points = repmat(x3(1), 20000, 1);
% 将额外的点加到数据的前面
x3 = [extra_points; x3];
% 选取数据点个数
num_points = 420000;
x3 = x3(1:num_points);
sigmoid1 = @(x) 1./(1+exp((-x+10)*1))*5+3;
% 创建一些示例数据
x_2 = 0:0.01:42;
y_2 = sigmoid1(x_2);
% 取第285000个点到300000个点
x33 = x3(287000:306000);


subplot(3,1,3);
plot(t/35,x3,'linewidth',1.5,'color',double([60	153	146]/255));
hold on;
plot(x_2/35, y_2, '--', 'linewidth',1.5,'color',double([60	153	146]/255));
set(gca,'ylim',[1,9],'FontName','Arial','FontSize',12,'FontWeight','bold');
set(gca, 'LineWidth', 1);
% 小图时间
L = length(x33); % 脉冲数量
t0 = 28.7+(0:L-1) * T; % 时间向量
%细节优化
hXLabel = xlabel('Stimulation (V)');
hYLabel = ylabel('Tension (g)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set(hYLabel, 'FontSize', 14,'FontWeight' , 'bold')
set(hXLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])





% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '寻找合适的刺激强度';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



%% 实验六：寻找合适的刺激频率
clc;clear;
num_points = 350000;

% CAPs
filename = 'C:\Users\DK\Desktop\Experimental data\Fig4\三通道自动刺激频率\起始1，步进3-CAPs.txt';

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
x1 = importdata(filename, delimiterIn, headerlinesIn);
x1 = x1(1:num_points);
x1(x1 < -0.08) = -0.08;
x1(x1 > 0.2) = 0.18;
Fs = 10000; % 采样率
T = 1 / Fs; % 采样间隔
L = length(x1); % 脉冲数量
t = (0:L-1) * T*(5/3.44); % 时间向量




% 临时作图
subplot(3,1,1);
plot(t-0.3,x1,'linewidth',1,'color',double([247,172,177]/255));
%set(gca,'ylim',[-10,50],'xlim',[0,90],'XTick',0:10:90,'FontName','Arial','FontSize',12);
set(gca,'ylim',[-0.12,0.25],'xlim',[0,50],'XTick',0:5:50,'FontName','Arial','FontSize',14,'FontWeight','bold');
set(gca, 'LineWidth',1);
% 设置x轴刻度标签的大小
ax = gca; % 获取当前坐标轴句柄
%ax.XAxis.FontSize = 2; % 设置x轴刻度标签的大小


% sEMG
filename = 'C:\Users\DK\Desktop\Experimental data\Fig4\三通道自动刺激频率\起始1，步进3-sEMG.txt';
% 设置导入参数
delimiterIn = '\n';
headerlinesIn = 0;
% 导入数据
x = importdata(filename, delimiterIn, headerlinesIn);
x = x(1:num_points);
Fs = 10000; % 采样率
T = 1 / Fs; % 采样间隔
L = length(x); % 脉冲数量
t = (0:L-1) * T*(5/3.44); % 时间向量
%细节优化
    
hXLabel = xlabel('Frequency (Hz)');
hYLabel = ylabel('CAPs (mv)');
% 赋色及属性调整

% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set(hYLabel, 'FontSize', 14,'FontWeight' , 'bold')
set(hXLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])



% 临时作图
subplot(3,1,2);
plot(t-0.3,x,'linewidth',1,'color',double([190,116,153]/255));
set(gca,'ylim',[-10,35],'FontName','Arial','FontSize',14,'FontWeight','bold');
set(gca,'xlim',[0,50],'XTick',0:5:50,'FontName','Arial','FontSize',14,'FontWeight','bold');
set(gca, 'LineWidth',1);

% 肌张力
filename = 'C:\Users\DK\Desktop\Experimental data\Fig4\三通道自动刺激频率\起始1，步进3-tension.txt';
% 设置导入参数
delimiterIn = '\n';
headerlinesIn = 0;
% 导入数据
x = importdata(filename, delimiterIn, headerlinesIn);
x = x(1:num_points);
Fs = 10000; % 采样率
T = 1 / Fs; % 采样间隔
L = length(x); % 脉冲数量
t = (0:L-1) * T*(5/3.44); 

%细节优化   
hXLabel = xlabel('Frequency (Hz)');
hYLabel = ylabel('sEMG (mv)');
% 赋色及属性调整
% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set(hYLabel, 'FontSize', 14,'FontWeight' , 'bold')
set(hXLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
    


% 临时作图
subplot(3,1,3);
plot(t-0.3,x,'linewidth',1,'color',double([60	153	146]/255));
set(gca,'ylim',[0,50],'yTick',0:25:50,'FontName','Arial','FontSize',12,'FontWeight','bold');
set(gca,'xlim',[0,50],'XTick',0:5:50,'FontName','Arial','FontSize',14,'FontWeight','bold');
set(gca, 'LineWidth',1);
%细节优化
hXLabel = xlabel('Frequency (Hz)');
hYLabel = ylabel('Tension (g)');
% 赋色及属性调整

% 字体和字号
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set(hYLabel, 'FontSize', 14,'FontWeight' , 'bold')
set(hXLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])



% 图片输出
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '寻找合适的刺激频率';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');

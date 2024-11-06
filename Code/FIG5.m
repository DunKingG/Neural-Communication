%% ʵ���ߣ���������״̬�µ���Ϣ����
% ��һ��ͼ����ԭʼ�ź�ͼ�ʹ����ź�ͼ
clc;clear;

% CAPs
filename = 'C:\Users\DK\Desktop\Experimental data\Fig5\��·�źŴ���\sEMG_1.2V,35Hz��0.2V,55Hz.txt';

%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

% ���õ������������������
delimiterIn = '\n';
headerlinesIn = 0;
x_raw = importdata(filename, delimiterIn, headerlinesIn);
%ɾ����28000���㵽��36000���㣬����������Զ������
start_index = 28000;
end_index = 36000;
x_raw(start_index:end_index) = [];
%�ƶ�����
num_deleted = end_index - start_index + 1;
x_raw(end-num_deleted+1:end) = [];
Fs = 10000; % ������
T = 1 / Fs; % �������
L = length(x_raw); % ��������
t = (0:L-1) * T; % ʱ������
%figure;

subplot(3,1,1);
plot(t,x_raw,'linewidth',0.001,'color',double([229,139,123]/255));
hTitle = title('Raw sEMG');
% ���ȴ���
x=x_raw;
x(abs(x) < 0.5) = 0;
x(x < 0) = 0;
%ϸ���Ż�   
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% ��ɫ�����Ե���
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% ������̶ȵ���
set(gcf,'Color',[1 1 1])
set(gca,'ylim',[-4,30],'yTick',0:15:30,'xlim',[0,35],'XTick',0:5:35,'FontName','Arial','FontSize',16);


subplot(3, 1, 2);
plot(t, x_raw,'linewidth',0.1,'color',double([149,209,157]/255));
hold on
plot(t, x,'linewidth',0.001,'color',double([229,139,123]/255));
hTitle = title('Signal Rectification');


%ϸ���Ż�
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% ��ɫ�����Ե���
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
set(gca,'ylim',[-4,30],'yTick',0:15:30,'xlim',[0,35],'XTick',0:5:35,'FontName','Arial','FontSize',16);



subplot(3, 1, 3);
% ���ȴ���
x(x > 0.5) = 25;
%ϸ���Ż�
hYLabel = ylabel('sEMG (mv)');
% ��ɫ�����Ե���
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')

% ������̶ȵ���
set(gca, 'YLim',[0 30])
set(gcf,'Color',[1 1 1])
set(gca,'ylim',[0,30],'yTick',0:15:30,'xlim',[0,35],'XTick',0:5:35,'FontName','Arial','FontSize',16);
plot(t, x,'linewidth',0.1,'color',double([149,209,157]/255));
hold on
plot(t, x_raw,'linewidth',0.001,'color',double([229,139,123]/255));
hTitle = title('Signal Calibration');
%ϸ���Ż�
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% ��ɫ�����Ե���

% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gca, 'YLim',[0 30])
set(gcf,'Color',[1 1 1])
set(gca,'ylim',[0,30],'yTick',0:15:30,'xlim',[0,35],'XTick',0:5:35,'FontName','Arial','FontSize',16);
 % ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'ԭʼ�ź�ͼ�ʹ����ź�ͼ';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



%% ����һ��ͼ��ʾƵ��
% ʱ���Ƶ��
%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on


NFFT = 2^nextpow2(L);
X = fft(x, NFFT) / L;
f = Fs / 2 * linspace(0, 1, NFFT / 2 + 1);
%figure;
% ��ͼ
plot(f, 2 * abs(X(1:NFFT / 2 + 1)),'linewidth',2,'color',double([229,139,123]/255));
hXLabel=xlabel('Frequency (Hz)','fontname','Arial','fontsize',14);
hYLabel=ylabel('sEMG (mV) ','fontname','Arial','fontsize',14);
hTitle =title('Frequency Spectrum');
set(gca,'xlim',[0,100],'FontName','Arial','FontSize',17,'FontWeight','bold');
set(gca, 'LineWidth',1);

set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 17, 'FontWeight' , 'bold')
% ����������
    set(gca, 'Box', 'on', ...                                % �߿�
        'Layer','top',...                                % ͼ��
       'XGrid', 'off', 'YGrid', 'on' )              % ����


set(gca, 'XLim',[0 100],'XTick', 0:5:100,'ylim',[0,1.8],'yTick',0:0.2:1.8,'FontSize',17)


% ���Ʒ���
rectangle('Position',[35.6-2 0 4 1], 'EdgeColor', '#06948E', 'LineWidth', 2); % 15Hz
rectangle('Position',[71.25-2 0 4 1], 'EdgeColor', '#818689', 'LineWidth', 2); % 40Hz
rectangle('Position',[55.8-2 0 4 1], 'EdgeColor', '#874290', 'LineWidth', 2); % 55Hz

% �������ⷽ���������ͼ��
h1 = plot(nan, nan, 's', 'MarkerEdgeColor', '#06948E', 'LineWidth', 2, 'MarkerSize', 10); % ��ɫ����
h2 = plot(nan, nan, 's', 'MarkerEdgeColor', '#874290', 'LineWidth', 2, 'MarkerSize', 10); % ��ɫ����
h3 = plot(nan, nan, 's', 'MarkerEdgeColor', '#818689', 'LineWidth', 2, 'MarkerSize', 10); % ��ɫ����

% ���ͼ��
legend([h1 h2 h3], {' Biological Signal(~35Hz) ', 'Engineered Signals(~55Hz)','Harmonic Noise(~70Hz)'}, 'FontSize', 15, 'FontWeight', 'bold');

     
% ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '����һ��ͼ��ʾƵ��';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');




%% �˲�
% �˲���55HZ
Fpass1 = 54;
Fpass2 = 56;
d = designfilt('bandpassiir', 'FilterOrder', 2, ...
    'HalfPowerFrequency1', Fpass1, 'HalfPowerFrequency2', Fpass2, ...
    'SampleRate', Fs);

% Ӧ���˲���
y = filter(d, x);

% ����
y(y < 0) = 0;


% ��˹�˾������Ҫ��������/��ӱ������ڵ���/��ֵ���ߣ�
% �����˹�˺���
%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on
sigma = 3000; % ��˹�˱�׼��
sz = 20000; % �˺�����С��ȷ���˺������ǵķ�Χ�㹻��
x = linspace(-sz / 2, sz / 2, sz);
gaussianKernel = exp(-x .^ 2 / (2 * sigma ^ 2)) / (sigma * sqrt(2 * pi));

% ���ź�y���о��
y_convolved = 4*conv(y, gaussianKernel, 'same');

% ���ƽ��
%figure;
subplot(3,1,1);
plot(t, y, 'linewidth', 0.001, 'color', double([229,139,123]/255));
title('Filtered Signal');
hXLabel =xlabel('Time (s)');
hYLabel = ylabel('sEMG (mV)');
grid on;
hTitle = title('Filtered Signal');%ϸ���Ż�
% ��ɫ�����Ե���
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% ������̶ȵ���
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
hTitle = title('Envelope Detected Signal');%ϸ���Ż�   
% ��ɫ�����Ե���
% ������ֺ�
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
% �������ģʽ
code = [1 0 1 1 0 1 1 1 0 0 1 0 1];
code_length = length(code);
interval = 2;

% ���ÿ��interval�ķָ��߲����ɫ��
for i = 1:code_length
    % ���㵱ǰɫ�����ʼλ�úͽ���λ�ã���x=2��ʼ
    x_start = 2 + (i - 1) * interval;
    x_end = 2 + i * interval;
    if code(i) == 1
        % ������ɫɫ��
        patch([x_start x_start x_end x_end], [-1 1 1 -1],[127,219,208] /255, 'FaceAlpha', 0.35, 'EdgeColor', 'none');
    end
    % ��ӱ�ע
    text((x_start + x_end) / 2, 0.9, num2str(code(i)), 'FontName', 'Arial', 'FontSize', 14, 'HorizontalAlignment', 'center','FontWeight' , 'bold');
    % ��ӷָ���
    xline(x_start,'--', 'color', 'k', 'LineWidth', 1);
end

% ������һ���ָ���
xline(2 + code_length * interval, '--','color', 'k', 'LineWidth', 1);
% �����ֵ����
yline(0.4, '--', 'Threshold',  'FontSize', 12, 'FontName', 'Arial','FontWeight' , 'bold','color', 'r', 'LineWidth', 2);
hTitle = title('Demodulated Signal');%ϸ���Ż�
       
% ��ɫ�����Ե���
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 16)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])


% ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '��������״̬�µ���Ϣ����';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



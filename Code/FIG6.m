%% ʵ��ˣ���ͨ���ŵ�����
%EXP8

clc;clear;
% CAPs
filename = 'C:\Users\DK\Desktop\Experimental data\Fig6\sEMG_0.25V_15Hz_55Hz_40Hz.txt';

%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

% ���õ������
delimiterIn = '\n';
headerlinesIn = 0;
x_raw = importdata(filename, delimiterIn, headerlinesIn);
Fs = 10000; % ������
T = 1 / Fs; % �������
L = length(x_raw); % ��������
t = (0:L-1) * T; % ʱ������

%figure;
subplot(3,1,1);
plot(t,x_raw,'linewidth',0.001,'color',double([229,139,123]/255));
set(gca,'ylim',[-10,50],'xlim',[0,90],'XTick',0:10:90,'FontName','Arial','FontSize',12);
hTitle =title('Raw sEMG');
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% ������̶ȵ���
set(gcf,'Color',[1 1 1])
    
subplot(3, 1, 2);
% �źű�׼��
x=x_raw;
x(abs(x) < 0.5) = 0;
x(x < 0) = 0;
%ϸ���Ż�
%Title
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% ��ɫ�����Ե���
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')

% ������̶ȵ���
set(gcf,'Color',[1 1 1])
plot(t, x_raw,'linewidth',0.001,'color',double([149,209,157]/255));
hold on
plot(t, x,'linewidth',2,'color',double([229,139,123]/255));
hTitle =title('Signal Rectification');
set(gca,'ylim',[-10,50],'xlim',[0,90],'XTick',0:10:90,'FontName','Arial','FontSize',12);
%ϸ���Ż�
%Title
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG  (mv)');
% ��ɫ�����Ե���
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% ������̶ȵ���
set(gca, 'YLim',[-10,50])
set(gcf,'Color',[1 1 1])

subplot(3, 1, 3);
% �źű�׼��
x1=x;
x(x > 0.5) = 42;
%ϸ���Ż�
%Title
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG (mv)');
% ��ɫ�����Ե���

% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% ������̶ȵ���
set(gca, 'YLim',[-10,50])
set(gcf,'Color',[1 1 1])
plot(t, x,'linewidth',0.001,'color',double([149,209,157]/255));
hold on
plot(t, x1,'linewidth',2,'color',double([229,139,123]/255));
hTitle =title('Signal Calibration');
set(gca,'ylim',[-10,50],'xlim',[0,90],'XTick',0:10:90,'FontName','Arial','FontSize',12);
%ϸ���Ż�
%Title
hXLabel = xlabel('Time (s)');
hYLabel = ylabel('sEMG  (mv)');
% ��ɫ�����Ե���
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
% ������̶ȵ���
set(gca, 'YLim',[-10,50])
set(gcf,'Color',[1 1 1])
% ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '�ŵ����á���ԭʼ�ź�ͼ�ʹ����ź�ͼ';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');


%% ����һ��ͼ��ʾƵ��
%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on


% ʱ���Ƶ��
NFFT = 2^nextpow2(L);
X = fft(x, NFFT) / L;
f = Fs / 2 * linspace(0, 1, NFFT / 2 + 1);

% ��ͼ
plot(f, 2 * abs(X(1:NFFT / 2 + 1)),'linewidth',2.5,'color',double([229,139,123]/255));
hXLabel=xlabel('Frequency (Hz)','fontname','Arial','fontsize',14);
hYLabel=ylabel('sEMG (mV) ','fontname','Arial','fontsize',14);
hTitle =title('Frequency Spectrum');
set(gca,'xlim',[0,100],'FontName','Arial','FontSize',12,'FontWeight','bold');
set(gca, 'LineWidth',1);
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 17, 'FontWeight' , 'bold')
% ����������
set(gca, 'Box', 'on', ...                                % �߿�
    'Layer','top',...                                % ͼ��
   'XGrid', 'off', 'YGrid', 'on' )              % ����
set(gca, 'XLim',[0 100],'XTick', 0:5:100)


% ���Ʒ���
rectangle('Position',[15.3-2 0 4 0.2], 'EdgeColor', '#06948E', 'LineWidth', 2); % 15Hz
rectangle('Position',[40.7-2 0 4 0.2], 'EdgeColor', '#874290', 'LineWidth', 2); % 40Hz
rectangle('Position',[55.8-2 0 4 0.2], 'EdgeColor', '#874290', 'LineWidth', 2); % 55Hz

% �������ⷽ���������ͼ��
h1 = plot(nan, nan, 's', 'MarkerEdgeColor', '#06948E', 'LineWidth', 2, 'MarkerSize', 10); % ��ɫ����
h2 = plot(nan, nan, 's', 'MarkerEdgeColor', '#874290', 'LineWidth', 2, 'MarkerSize', 10); % ��ɫ����

% ���ͼ��
legend([h1 h2], {' Biological Signal(~15Hz) ', 'Engineered Signals(~55Hz and ~40Hz)'}, 'FontSize', 14, 'FontWeight', 'bold');

% ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '�ŵ�����-����һ��ͼ��ʾƵ��';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



%% �˲�
% �˲���40HZ
Fpass1 = 39;
Fpass2 = 41;
d = designfilt('bandpassiir', 'FilterOrder', 2, ...
    'HalfPowerFrequency1', Fpass1, 'HalfPowerFrequency2', Fpass2, ...
    'SampleRate', Fs);

% Ӧ���˲���
y1 = filter(d, x);
% ����
y1(y1 < 0) = 0;
% �˲���55HZ
Fpass1 = 54;
Fpass2 = 56;
d = designfilt('bandpassiir', 'FilterOrder', 2, ...
    'HalfPowerFrequency1', Fpass1, 'HalfPowerFrequency2', Fpass2, ...
    'SampleRate', Fs);

% Ӧ���˲���
y2 = filter(d, x);
% ����
y2(y2 < 0) = 0;
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
sigma = 5000; % ��˹�˱�׼��
sz = 20000; % �˺�����С��ȷ���˺������ǵķ�Χ�㹻��
x = linspace(-sz / 2, sz / 2, sz);
gaussianKernel = exp(-x .^ 2 / (2 * sigma ^ 2)) / (sigma * sqrt(2 * pi));

% ���ź�y���о��
y1_convolved = 4*conv(y1, gaussianKernel, 'same');

% ���ƽ��
%figure;
subplot(3,2,1);
plot(t, y1, 'linewidth', 0.001, 'color', double([229,139,123]/255));
hTitle =title('Filtered Signal A');
hXLabel =xlabel('Time (s)');
hYLabel =ylabel('sEMG (mV)');
grid on;
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(hYLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% ������̶ȵ���
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
 % ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 13, 'FontWeight' , 'bold')
set(hYLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
set(gca, 'XLim',[0 90],'XTick', 0:30:90,'YLim',[0 0.65],'YTick', 0:0.2:0.65)
% ���ź�y���о��
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

% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel, hYLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(hYLabel, 'FontSize', 14, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
set(gca, 'XLim',[0 90],'XTick', 0:30:90,'YLim',[0 0.7],'YTick', 0:0.2:0.7)


% ���ź�y���о��
y2_convolved = 4*conv(y2, gaussianKernel, 'same');
% �������ģʽ
code = [1 1 0 0 1 1 0 0 1 1 0 1 1];
code_length = length(code);
interval = 5.9;

% ���ÿ��interval�ķָ��߲����ɫ��
for i = 1:code_length
    % ���㵱ǰɫ�����ʼλ�úͽ���λ�ã���x=2��ʼ
    x_start = 5 + (i - 1) * interval;
    x_end = 5 + i * interval;
    
    if code(i) == 1
        % ������ɫɫ��
        patch([x_start x_start x_end x_end], [-1 1 1 -1],[127,219,208] /255, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    end
 

    % ��ӱ�ע
    text((x_start + x_end) / 2, 0.6, num2str(code(i)), 'FontName', 'Arial', 'FontSize', 12, 'HorizontalAlignment', 'center','FontWeight' , 'bold');
    
    
    % ��ӷָ���
    xline(x_start,'--', 'color', 'k', 'LineWidth', 1);
end

% ������һ���ָ���
xline(5 + code_length * interval, '--','color', 'k', 'LineWidth', 1);
yline(0.4, '--', 'color', 'r', 'LineWidth', 2);




 % ���ƽ��
subplot(3,2,2);
plot(t, y2, 'linewidth', 0.001, 'color', double([229,139,123]/255));
hTitle=title('Filtered Signal B');
hXLabel =xlabel('Time (s)');
grid on;
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% ������̶ȵ���
set(gca, 'XLim',[0 35],'XTick', 0:10:35,'YLim',[0 0.75],'YTick', 0:0.2:0.75)

subplot(3,2,4);
plot(t, y2, 'linewidth', 0.001, 'color', double([228,171,151]/255));
hold on
plot(t, y2_convolved, 'linewidth', 2, 'color', double([190,116,153]/255));
hTitle=title('Envelope Detected Signal B');
hXLabel =xlabel('Time (s)');

grid on;
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set(hXLabel, 'FontSize', 16, 'FontWeight' , 'bold')
set(hTitle, 'FontSize', 13, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% ������̶ȵ���
set(gca, 'XLim',[0 35],'XTick', 0:10:35,'YLim',[0 0.75],'YTick', 0:0.2:0.75)




subplot(3,2,6);
plot(t, y2, 'linewidth', 0.001, 'color', double([228,171,151]/255));
hold on
plot(t, y2_convolved, 'linewidth', 2, 'color', double([190,116,153]/255));
hTitle=title('Demodulated Signal B');
hXLabel =xlabel('Time (s)');
grid on;
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 14)
set([hTitle, hXLabel], 'FontSize', 16, 'FontWeight' , 'bold')
set(gcf,'Color',[1 1 1])
% ������̶ȵ���
set(gca, 'XLim',[0 35],'XTick', 0:10:35,'YLim',[0 0.85],'YTick', 0:0.2:0.85)


 % �������ģʽ
code = [1 0 1 1 0 1 1 1 0 0 1 0 1];
code_length = length(code);
interval = 2;

% ���ÿ��interval�ķָ��߲����ɫ��
for i = 1:code_length
    % ���㵱ǰɫ�����ʼλ�úͽ���λ�ã���x=2��ʼ
    x_start = 6.5 + (i - 1) * interval;
    x_end = 6.5 + i * interval;
    if code(i) == 1
        % ������ɫɫ��
        patch([x_start x_start x_end x_end], [-1 1 1 -1],[127,219,208] /255, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    end
    % ��ӱ�ע
    text((x_start + x_end) / 2, 0.74, num2str(code(i)), 'FontName', 'Arial', 'FontSize', 12, 'HorizontalAlignment', 'center','FontWeight' , 'bold');
    % ��ӷָ���
    xline(x_start,'--', 'color', 'k', 'LineWidth', 1);
end

% ������һ���ָ���
xline(6.5 + code_length * interval, '--','color', 'k', 'LineWidth', 1);
yline(0.4, '--', 'color', 'r', 'LineWidth', 2);

 % ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '�ŵ�����';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');




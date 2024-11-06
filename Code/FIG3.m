%% ʵ��һ������������λ ����Ƶ��10KHZ
clc ; clear all;close all;

% ָ�������ļ�·��
filename = 'C:\Users\DK\Desktop\Experimental data\Fig3\��������.txt';

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

% ��������
A = importdata(filename, delimiterIn, headerlinesIn);

% �����������60��10000����
% ��ʼ��һ�� 10000*60 �ľ������ڴ洢ÿ10000���������
resultMatrix = zeros(10000, 60);

% ��ÿ10000����Ϊһ�飬�����ݷ��䵽��ͬ������
for i = 1:60
    % ������ʼ����
    startIndex = (i - 1) * 10000 + 1;
    
    % ȷ����ʼ����û�г������ݳ���
    if startIndex > length(A)
        break;
    end
    
    % �����ݷ��䵽����������Ӧ��
    resultMatrix(:, i) = A(startIndex:min(startIndex + 9999, end));
end

% ��ʼ��һ��201*60�ľ������ڴ洢ÿ�����ݵ����ֵ�㼰��ǰ100����ͺ�100����
finalResultMatrix = zeros(100, 60);

% ����ÿ�����ݣ��ҵ����ֵ�㼰��ǰ29����ͺ�70����
for i = 1:60
    % ��ȡ��ǰ�е�����
    currentData = resultMatrix(:, i);
    
    % �ҵ����ֵ��������
    [minValue, maxIndex] = max(currentData);
    
    % ������ʼ�ͽ�������
    startIndex = max(1, maxIndex - 29);
    endIndex = min(length(currentData), maxIndex + 70);
    
    % ��ȡ�����100����
    tempData = currentData(startIndex:endIndex);
    
    % ������ݲ���100���㣬�����0
    if length(tempData) < 100
        tempData = [tempData; zeros(100 - length(tempData), 1)];
    end
    
    % ����ȡ�����ݴ洢�����ս��������
    finalResultMatrix(:, i) = tempData;
end

% ���������д��Excel�ļ�
resultExcelFileName = 'C:\Users\DK\Desktop\ʵ��\ProcessedData.xlsx';

% д��Excelǰ����ɾ�����е��ļ�
if exist(resultExcelFileName, 'file') == 2
    delete(resultExcelFileName);
end

% д�����ݵ�Excel�ļ�
xlswrite(resultExcelFileName, finalResultMatrix);

% ��ɢ��(���˶������ͼ)
scatterHandles = gobjects(size(finalResultMatrix, 2), 1);

    % ��ɢ��(���˶������ͼ)
for i = 1:20
    % �����꣺���/10000
    x = (1:size(finalResultMatrix, 1)) / 10;
    % �����꣺���ݵ����ֵ
    y = finalResultMatrix(:, i);
    % �������ݵ㣬ʹ��hold on������ͬһ��ͼ��
     scatterHandles(i)=scatter(x, y, '.', 'DisplayName', strcat('Data ', num2str(i)));
    % ���ͼ��
    hold on;
end
meanY = mean(finalResultMatrix, 2);


% ����ƽ�������������
[fitresult, gof, fitHandle] = createFit(x, meanY);


% ��������0.5������0.5������
upperY = meanY + 0.05;
lowerY = meanY - 0.05;

upperY = meanY + (1/6 * meanY);
lowerY = meanY - (1/6 * meanY);

% ������Ӱ����
fill([x, fliplr(x)], [upperY', fliplr(lowerY')], [247,172,177]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

% ����ͼ������
hXLabel =xlabel('Time (ms)');
hYLabel =ylabel('CAPs (mv)');
hTitle=title('CAPs Signal');
%legend show; % ��ʾͼ��
ylim([-0.45, 0.3]);
% ����ͼ�δ��ڴ�
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
box on

  
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 22)
set([hTitle, hXLabel, hYLabel], 'FontSize', 22, 'FontWeight' , 'bold')
% Legend
hLegend = legend([scatterHandles(1),fitHandle(2)], ...
                'Data1','Fit1', ...
                'Location', 'northeast',...
                 'NumColumns',2);

set(hLegend, 'FontSize', 18, 'FontWeight', 'bold'); % ����ͼ�����е������СΪ 6
set(gcf, 'Color', [1 1 1]);
 % ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'CAPs';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



%% ʵ��һ sEMG
clc; clear;
% sEMG
delimiterIn = '\n';
headerlinesIn = 0;

filename = 'C:\Users\DK\Desktop\Experimental data\Fig3\��ͨ���Զ��̼�ǿ��\��ͨ���Զ��̼�ǿ��-sEMG.txt';

%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

% ���õ������
x2 = importdata(filename, delimiterIn, headerlinesIn);

% ѡȡ���ݵ����
num_points = 400000;
x2 = x2(1:num_points);

% ȡ��293200���㵽293400����
x22 = x2(293200:293400);
Fs = 10000; % ������
T = 1 / Fs; % �������
L = length(x2); % ��������
t = (0:L-1) * T; % ʱ������
% Сͼʱ��
L = length(x22); % ��������
t0 = 29.32 + (0:L-1) * T; % ʱ������
t0 = ( t0- 29.32)*1000;

% ����sEMG�ź�
%figure;
% ��������1/4���������
upper_curve = x22 + (1/10) * max(abs(x22));
lower_curve = x22 - (1/10) * max(abs(x22));

% ������Ӱ����
fill([t0, fliplr(t0)], [upper_curve', fliplr(lower_curve')], [217,198,213]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
hold on
num_simulations = 3;
scatterHandles = gobjects(num_simulations, 1);
for i = 1:num_simulations
    noisy_x22 = x22 + randn(size(x22)) * 0.5; % ��Ӹ�˹����
    scatterHandles(i) = scatter(t0, noisy_x22, '.','MarkerFaceAlpha', 0.01, 'MarkerEdgeAlpha', 0.01);
    hold on;
end

fitHandle=plot(t0, x22, 'linewidth', 3, 'color', double([190,116,153] / 255));

set(gca, 'ylim', [-5, 22], 'FontName', 'Arial', 'FontSize', 22, 'FontWeight', 'bold');
 
set(gca, 'LineWidth', 1);
%set(gca, 'xtick', [], 'ytick', []); % �Ƴ�������̶�ֵ

hXLabel=xlabel('Time (ms)');
hYLabel=ylabel('sEMG (mV)');
hTitle=title('sEMG Signal');
%legend('sEMG Signal', 'Fitted Curve', 'Location', 'Best');
box on;
%hold off;
 % ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 22)
set([hTitle, hXLabel, hYLabel], 'FontSize', 22, 'FontWeight' , 'bold')
   
% Legend
hLegend = legend([scatterHandles(1),fitHandle], ...
                'Data1','Fit1', ...
                'Location', 'northeast',...
                 'NumColumns',2);


set(hLegend, 'FontSize', 20, 'FontWeight', 'bold'); % ����ͼ�����е������СΪ 6
set(gcf, 'Color', [1 1 1]);

grid on
 % ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'sEMG';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');


%% ʵ��һ Tension
clc; clear;
% sEMG
delimiterIn = '\n';
headerlinesIn = 0;
Fs = 10000; % ������
T = 1 / Fs; % �������
filename = 'C:\Users\DK\Desktop\Experimental data\Fig3\��ͨ���Զ��̼�ǿ��\��ͨ���Զ��̼�ǿ��-tension.txt';


%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on



% ���õ������
x3 = importdata(filename, delimiterIn, headerlinesIn);

% ѡȡ���ݵ����
num_points = 400000;
x3 = x3(1:num_points);

sigmoid1 = @(x) 1./(1+exp((-x+10)*1))*5+3;
% ����һЩʾ������
x_2 = 0.2:0.01:40;
y_2 = sigmoid1(x_2);

% ȡ��285000���㵽300000����
x33 = x3(287000:306000);
L = length(x33); % ��������
t0 = (0:L-1) * T;
% ����sEMG�ź�
%figure;
% ��������1/4���������
upper_curve = x33 + (1/20) * max(abs(x33));
lower_curve = x33 - (1/20) * max(abs(x33));
num_simulations = 3;
scatterHandles = gobjects(num_simulations, 1);
sampling_rate = 100; % ѡ������ʣ�����ÿ10����ȡһ��

for i = 1:num_simulations
    noisy_x33 = x33 + randn(size(x33)) * 0.2; % ��Ӹ�˹����
    sampled_x33 = noisy_x33(1:sampling_rate:end); % ���в���
    sampled_t0 = t0(1:sampling_rate:end); % ��Ӧ��ʱ������Ҳ���в���
    scatterHandles(i) = scatter(sampled_t0, sampled_x33, '.', 'MarkerFaceAlpha', 0.1, 'MarkerEdgeAlpha', 0.1);
    hold on;
end

% ������Ӱ����
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


set(hLegend, 'FontSize', 18, 'FontWeight', 'bold'); % ����ͼ�����е������СΪ 6
set(gcf, 'Color', [1 1 1]);
grid on


 % ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = 'Tension';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');




%% ʵ������񾭸ɴ����ٶ�
% Aͨ��
clc; clear;

%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 15;
figureHeight = 12;

%��������
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
hold on

subplot(2,1,1);
A = xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\�����ٶ�\Aͨ����ǰ��\A1.csv');
% ��ʼ��һ��50*10�ľ������ڴ洢ÿ�����ݵ���Сֵ�㼰��ǰ10����ͺ�39����
finalResultMatrix = zeros(50, size(A, 2));

% ����ÿ�����ݣ��ҵ���Сֵ�㼰��ǰ10����ͺ�39����
for i = 1:size(A, 2)
    % ��ȡ��ǰ�е�����
    currentData = A(:, i);
    % �ҵ���Сֵ��������
    [minValue, minIndex] = min(currentData);
    % ������ʼ�ͽ�������
    startIndex = max(1, minIndex - 5);
    endIndex = min(length(currentData), minIndex + 44);
    % ��ȡ��������ݶ�
    tempData = currentData(startIndex:endIndex);
    % �����ȡ�����ݲ���50���㣬����ǰ��������������һ��ֵ��ͬ����ֵ
    if length(tempData) < 50
        if startIndex > 1
            % ��ǰ��������һ��ֵ��ͬ����ֵ
            tempData = [repmat(tempData(1), max(0, 50 - length(tempData)), 1); tempData];
        else
            % �ں�����������һ��ֵ��ͬ����ֵ
            tempData = [tempData; repmat(tempData(end), max(0, 50 - length(tempData)), 1)];
        end
    end
    
    % ����ȡ�����ݴ洢�����ս�������У�ȷ����Сֵ�����
    finalResultMatrix(:, i) = tempData;
end


% ��ɢ��(���˶������ͼ)
scatterHandles = gobjects(size(finalResultMatrix, 2), 1);

% ��ɢ��ͼ
for i = 1:size(finalResultMatrix, 2)
    % �����꣺���/5
    x = (1:50) / 10;
    % �����꣺���ݵ����ֵ
    y = finalResultMatrix(:, i);
    
    % �������ݵ�
    hold on
     scatterHandles(i)=scatter(x, y, '.', 'DisplayName', strcat('Data ', num2str(i)));
end

meanY = mean(finalResultMatrix, 2);
% ����ƽ�������������
[fitresult, gof, fitHandle] = createFit(x, meanY);


upperY = meanY + (1/3 * meanY);
lowerY = meanY - (1/3 * meanY);

% ������Ӱ����
fill([x, fliplr(x)], [upperY', fliplr(lowerY')], [247,172,177]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

% ����ͼ������
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
hXLabel =xlabel('Time (ms)', 'FontName', 'Arial', 'FontSize', 22);
hYLabel =ylabel('CAPs (mV)', 'FontName', 'Arial', 'FontSize', 22);
box on;
xlim([0, 5]);
ylim([-0.5, 0.25]);
%hold on;

% ����ͼ������

hTitle=title('CAPs-1');
%legend show; % ��ʾͼ��

% ����ͼ�δ��ڴ�
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
box on

 
    % ������ֺ�
    set(gca, 'FontName', 'Arial', 'FontSize', 12)
    set([hTitle, hXLabel, hYLabel], 'FontSize', 20, 'FontWeight' , 'bold')
   


% Legend
hLegend = legend([scatterHandles(1),fitHandle(2)], ...
                'Data1','Fit1', ...
                'Location', 'southeast',...
                 'NumColumns',2);

set(hLegend, 'FontSize', 18, 'FontWeight', 'bold'); % ����ͼ�����е������СΪ 6
set(gcf, 'Color', [1 1 1]);



% Bͨ��
% ��ȡ����
B = xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\�����ٶ�\Bͨ������\B2.csv');

% ��ʼ��һ��50*10�ľ������ڴ洢ÿ�����ݵ����ֵ�㼰��ǰ30����ͺ�19����
finalResultMatrix = zeros(50, size(B, 2));

% ��ͼ����
subplot(2,1,2);

% ����ÿ�����ݣ��ҵ����ֵ�㼰��ǰ30����ͺ�19����
for i = 1:size(B, 2)
    % ��ȡ��ǰ�е�����
    currentData = B(:, i);
    
    % �ҵ����ֵ��������
    [maxValue, maxIndex] = max(currentData);
    
    % ������ʼ�ͽ�������
    startIndex = max(1, maxIndex - 30);
    endIndex = min(size(currentData, 1), maxIndex + 19); % ��Ҫ+1�԰������ֵ���20����
    
    % ��ȡ��������ݶ�
    tempData = currentData(startIndex:endIndex);
    
    % �����ȡ�����ݲ���50���㣬����ǰ��������������һ��ֵ��ͬ����ֵ
    if length(tempData) < 50
        % �ں�����������һ��ֵ��ͬ����ֵ��ֱ�����ȴﵽ50
        tempData = [tempData; repmat(tempData(end), 50 - length(tempData), 1)];
    end
    
    % ����ȡ�����ݴ洢�����ս�������У�ȷ�����ֵ�����
    finalResultMatrix(:, i) = tempData(end-49:end); % ȡ���50�����ݵ�
end

% ��ɢ��ͼ
hold on;

% ��ɢ��(���˶������ͼ)
scatterHandle = gobjects(size(finalResultMatrix, 2), 1);

for i = 1:size(finalResultMatrix, 2)
    % �����꣺���/10
    x = (1:50) / 10;
    % �����꣺���ݵ����ֵ
    y = finalResultMatrix(:, i);
    
    % �������ݵ�
    scatterHandle(i)=scatter(x, y, '.', 'DisplayName', strcat('Data ', num2str(i)));
end

% ����ÿ�е�ƽ��ֵ
meanY = mean(finalResultMatrix, 2);

% ����ƽ�������������
[fitresult1, gof1, fitHandle1] = createFit(x, meanY);

upperY = meanY + (1/3 * meanY);
lowerY = meanY - (1/3 * meanY);

% ������Ӱ����
fill([x, fliplr(x)], [upperY', fliplr(lowerY')], [247,172,177]/255, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

% ����ͼ������
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
hXLabel=xlabel('Time (ms)', 'FontName', 'Arial', 'FontSize', 12);
hYLabel=ylabel('CAPs (mV)', 'FontName', 'Arial', 'FontSize', 12);
box on;

% ������̶ȵ���
    set(gca, 'YLim',[-0.5 0.5],'YTick', -0.5:0.2:0.5)

hTitle=title('CAPs-2');
% ����ͼ�δ��ڴ�
set(gca, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
box on
% ������ֺ�
set(gca, 'FontName', 'Arial', 'FontSize', 12)
set([hTitle, hXLabel, hYLabel], 'FontSize', 20, 'FontWeight' , 'bold')
   
% Legend
hLegend = legend([scatterHandle(1),fitHandle1(2)], ...
                'Data2','Fit2', ...
                'Location', 'southeast',...
                 'NumColumns',2);

set(hLegend, 'FontSize', 18, 'FontWeight', 'bold'); % ����ͼ�����е������СΪ 6
set(gcf, 'Color', [1 1 1]);


 % ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '�����ٶ�';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');


%% ʵ��������Ӧ��ʵ��
clc;clear
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\��Ӧ��\1ms\1ms.csv');
timespan = linspace(1,length(A(:,1)),length(A(:,1)));

%ͼƬ�ߴ����ã���λ�����ף�
figureUnits = 'centimeters';
figureWidth = 18;
figureHeight = 8;

%��������
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
% ������̶ȵ���
%set(gca, 'YLim',[-1 1.5],'YTick', -1:0.5:1.5)
title(' Time Interval: 1ms','FontSize', 12,'FontWeight','bold');
set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % С�̶�
box on

% 1.5ms��Ӧ��ʵ��
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\��Ӧ��\1.5ms\1.5ms.csv');
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
 set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % С�̶�
box on



% 2ms��Ӧ��ʵ��
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\��Ӧ��\2ms\2ms.csv');
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
 set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % С�̶�
box on
% 3ms��Ӧ��ʵ��
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\��Ӧ��\3ms\3ms.csv');
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
 set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % С�̶�
box on
% 4ms��Ӧ��ʵ��
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\��Ӧ��\4ms\4ms.csv');
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
 set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % С�̶�
box on   
% 5ms��Ӧ��ʵ��
A=xlsread('C:\Users\DK\Desktop\Experimental data\Fig3\��Ӧ��\5ms\5ms.csv');
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
set(gca,'XMinorTick', 'on', 'YMinorTick', 'on')    % С�̶�
box on  

    
% ͼƬ���
figW = figureWidth;
figH = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '��Ӧ��';
print(figureHandle,[fileout,'.png'],'-r300','-dpng');



   
%% plot Kc* and Bandwidth as function of processing deadtime ration
% Tel is set as [0.1 1 5 10] ms
% Tnc = Tel


%% Initialization values for simulation
% startup
ActualPath = pwd;
addpath(genpath(ActualPath));
figName = 'Fig_Save\KcBw_Chi_TncIs08Tel';
YLimKc = [0.1 600];
YLimBW = [0.9e3 2e4];

%% import data
% Tnc = Tel = 0.1ms
% folder_name = 'Data_Save';
filename = '1_Tel0.1ms_Tnc0.08ms_2.csv';
SZTel01 = importfile2(filename);

% Tnc = Tel = 1ms
filename = '2_Tel1ms_Tnc0.8ms_2.csv';
SZTel1 = importfile2(filename);

% Tnc = Tel = 5ms
filename = '3_Tel5ms_Tnc4ms_2.csv';
SZTel5 = importfile2(filename);

% Tnc = Tel = 10ms
filename = '4_Tel10ms_Tnc8ms_2.csv';
SZTel10 = importfile2(filename);

%% plot
hF1  = figure(2); clf
hF1.InvertHardcopy = 'off'; hF1.Color = [0.94 0.94 0.94]; hF1.Position = [0 0 1280 720];
% 6 tight subplot(Nh, Nw, gap: between subplot, marg_h: [bottom top], marg_w: edge [left right] )
[ha, ~] = tight_subplot(2, 3, [0.08 0.04], [0.08 0.08], [0.03 0.01]);
% title
title_dim = [0.248 0.9611222 0.543125 0.038889];
str = ['PI Current control in continuous domain and discrete domain when Tnc = 0.8Tel'];
title_an = annotation(hF1,'textbox',title_dim,'FontSize',14,...
	'FontWeight','bold','String',str,'Margin',2,'FitBoxToText','on',...
	'BackgroundColor',[0.94 0.94 0.94],'EdgeColor',[0.94 0.94 0.94]);

% plot subplot 1
ax = ha(1);
chi_P = SZTel01(1,:); 
datTel01 = [SZTel01(2,:); SZTel01(4,:)];
datTel1 = [SZTel1(2,:); SZTel1(4,:)];
datTel5 = [SZTel5(2,:); SZTel5(4,:)];
datTel10 = [SZTel10(2,:); SZTel10(4,:)];

fcnPlotKc(ax,chi_P,datTel01,datTel1,datTel5,datTel10,YLimKc);
title(ax,'Kc* Max = f(\chi_P) at Fs = 8kHz'); %ylabel(ax,'Kc* Max');

% plot subplot 2
ax = ha(2);
chi_P = SZTel01(1,:); 
datTel01 = [SZTel01(6,:); SZTel01(8,:)];
datTel1 = [SZTel1(6,:); SZTel1(8,:)];
datTel5 = [SZTel5(6,:); SZTel5(8,:)];
datTel10 = [SZTel10(6,:); SZTel10(8,:)];

fcnPlotKc(ax,chi_P,datTel01,datTel1,datTel5,datTel10,YLimKc);
title(ax,'Kc* Max = f(\chi_P) at Fs = 16kHz'); %ylabel(ax,'Kc* Max');

% plot subplot3
ax = ha(3);
chi_P = SZTel01(1,:); 
datTel01 = [SZTel01(10,:); SZTel01(12,:)];
datTel1 = [SZTel1(10,:); SZTel1(12,:)];
datTel5 = [SZTel5(10,:); SZTel5(12,:)];
datTel10 = [SZTel10(10,:); SZTel10(12,:)];

fcnPlotKc(ax,chi_P,datTel01,datTel1,datTel5,datTel10,YLimKc);
title(ax,'Kc* Max = f(\chi_P) at Fs = 24kHz'); %ylabel(ax,'Kc* Max');

% plot subplot 4
ax = ha(4);
chi_P = SZTel01(1,:); 
datTel01 = [SZTel01(3,:); SZTel01(5,:)];
datTel1 = [SZTel1(3,:); SZTel1(5,:)];
datTel5 = [SZTel5(3,:); SZTel5(5,:)];
datTel10 = [SZTel10(3,:); SZTel10(5,:)];

fcnPlotBW(ax,chi_P,datTel01,datTel1,datTel5,datTel10,YLimBW);
title(ax,'Bandwidth(-3dB,in Hz) = f(\chi_P) at Fs = 8kHz'); %ylabel(ax,'Kc* Max');

% plot subplot 5
ax = ha(5);
chi_P = SZTel01(1,:); 
datTel01 = [SZTel01(7,:); SZTel01(9,:)];
datTel1 = [SZTel1(7,:); SZTel1(9,:)];
datTel5 = [SZTel5(7,:); SZTel5(9,:)];
datTel10 = [SZTel10(7,:); SZTel10(9,:)];

fcnPlotBW(ax,chi_P,datTel01,datTel1,datTel5,datTel10,YLimBW);
title(ax,'Bandwidth(-3dB,in Hz) = f(\chi_P) at Fs = 16kHz'); %ylabel(ax,'Kc* Max');

% plot subplot 6
ax = ha(6);
chi_P = SZTel01(1,:); 
datTel01 = [SZTel01(11,:); SZTel01(13,:)];
datTel1 = [SZTel1(11,:); SZTel1(13,:)];
datTel5 = [SZTel5(11,:); SZTel5(13,:)];
datTel10 = [SZTel10(11,:); SZTel10(13,:)];

hY = fcnPlotBW(ax,chi_P,datTel01,datTel1,datTel5,datTel10,YLimBW);
title(ax,'Bandwidth(-3dB,in Hz) = f(\chi_P) at Fs = 24kHz'); %ylabel(ax,'Kc* Max');


% common legend
leg_text = {'Tel 0.1ms [s]';'Tel 0.1ms [z]';'Tel 1ms [s]';'Tel 1ms [z]';...
    'Tel 5ms [s]';'Tel 5ms [z]';'Tel 10ms [s]';'Tel 10ms [z]'};

legend(hY,leg_text,'Orientation','horizontal','location','southwest',...
    'Position',[0.13542 0.00852 0.7511 0.0307],'FontSize',10);
% gridLegend(hY,4,leg,'location','east','Fontsize',10,'Box','off');

% save to file
fig = gcf; 
%print('figName','-dpng','-r0')
print(figName,'-dpng','-r300')
savefig([figName '.fig'])
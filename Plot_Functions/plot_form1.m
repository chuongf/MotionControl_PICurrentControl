function [ha,an] = plot_form1(hF1,ha, Gws, Sens, Gwz, Senz, bandwidth,Ts,text_dim)
%% plot results to to a created form

%% decode data
chi_P = bandwidth(1);
KcnMax_vals = bandwidth(2); 
GwsBWGain3dB_vals = bandwidth(3); 
SenBWGain3dB_vals = bandwidth(4);
KcnMax_valz = bandwidth(5); 
GwsBWGain3dB_valz = bandwidth(6); 
SenBWGain3dB_valz = bandwidth(7); 
                
%% plot option
opt = bodeoptions; opt.FreqUnits = 'Hz'; opt.Grid = 'on';
opt.PhaseVisible = 'off';
opt.XlimMode = 'manual'; opt.YlimMode =  'manual';
opt.Xlim = [1 20e3]; opt.Ylim = [-9 6];
% text
% steps_dim = [0.2 0.6 0.0928 0.0922]; 
steps_dim = text_dim(1:4);
% stepz_dim = [0.2 0.131 0.0928 0.0922];
stepz_dim = text_dim(5:8);

%% continous 
% figure 2: bode of Gws
opt.XlimMode = 'manual'; opt.YlimMode =  'manual';
bodeplot(ha(2), Gws,opt); set(findall(ha(2),'type','line'),'linewidth',1);
title(['Gws bode plot: BW-3dB = {\color{red}' num2str((GwsBWGain3dB_vals/1000),2) 'kHz}'],...
    'FontSize',11,'FontWeight','bold');
hold(ha(2),'on');
plot(ha(2),[GwsBWGain3dB_vals GwsBWGain3dB_vals],[-9 6],'r--')
hold(ha(2),'off');
% figure 3: bode of sensitivity function
opt.XlimMode = 'manual'; opt.YlimMode =  'auto';
bodeplot(ha(3),Sens,opt); set(findall(ha(3),'type','line'),'linewidth',1);
title(['Sensitivity plot: BW-3dB = {\color{red}' num2str((SenBWGain3dB_vals/1000),2) 'kHz}'],...
    'FontSize',11,'FontWeight','bold'); 

% figure 1: Step of Gws
step(ha(1),Gws,4e-4); ylim([0 1.2]);
set(findall(ha(1),'type','line'),'linewidth',1.5);
grid on; title('Gws step response',...
    'FontSize',11,'FontWeight','bold');

% Additional data in a textbox
% if(exist("an1", "var"))
%     delete(an1);
% end
str = {['Fs = ' num2str(0.001/Ts) ' kHz'],...
    ['\chi = ' num2str(chi_P)]...
    ['Kc* Max = ' num2str(KcnMax_vals)]};
an1 = annotation(hF1,'textbox',steps_dim,'FontSize',12,'String',...
    str,'Margin',2,'FitBoxToText','on','BackgroundColor',[1 1 1]);

%% discrete

% figure 5: bode of Gws
opt.XlimMode = 'manual'; opt.YlimMode =  'manual';
bodeplot(ha(5),Gwz,opt); set(findall(gcf,'type','line'),'linewidth',1);
title(['Gwz bode plot: BW-3dB = {\color{red}' num2str((GwsBWGain3dB_valz/1000),2) 'kHz}'],...
    'FontSize',11,'FontWeight','bold');
hold(ha(5),'on');
plot(ha(5),[GwsBWGain3dB_valz GwsBWGain3dB_valz],[-9 6],'r--')
hold(ha(5),'off');

% figure 6: bode of sensitivity function
opt.XlimMode = 'manual'; opt.YlimMode =  'auto';
bodeplot(ha(6),Senz,opt);set(findall(gcf,'type','line'),'linewidth',1);
title(['Sensitivity plot: BW-3dB = {\color{red}' num2str((SenBWGain3dB_valz/1000),2) 'kHz}'],...
    'FontSize',11,'FontWeight','bold'); 

% figure 4: Step of Gws
step(ha(4),Gwz,4e-4); ylim([0 1.2]);
set(findall(gcf,'type','line'),'linewidth',1);
grid on; title('Gwz step response',...
    'FontSize',11,'FontWeight','bold');

str = {['Fs = ' num2str(0.001/Ts) ' kHz'],...
    [ '\chi = ' num2str(chi_P)]...
    ['Kc* Max = ' num2str(KcnMax_valz)]};
an2 = annotation(hF1,'textbox',stepz_dim,'FontSize',12,'String',...
    str,'Margin',2,'FitBoxToText','on','BackgroundColor',[1 1 1]);

%% render
an = [an1 an2];
drawnow;
pause(0.1);

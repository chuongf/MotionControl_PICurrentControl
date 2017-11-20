%% PI current control in s domain and z domain
% this script select value for Tel, Tnc, Fs, deadtime and find the maximum
% gain at which the system has specific overshoot.
%
% Tel is choosen in range motor power 40W (0.1ms) to 4KW (10ms)
%
% Tnc is choosen 80% to 140% Tel because the optimal value is Tel. but since
% the operation temperature of motor change, the value Tel also change ~40%
%
% Sampling frequency is tested at 8kHz, 16kHz and 24kHz
% 
% Processing deadtime ration is in step of 0.05
%
% Overshoot is choosen at 10%
%
% Writen by Chuong Nguyen, Nov 2017 
% Version 2.0
% For master thesis at Rosenheim Applied Science University

%% Initialization values for simulation
% startup
ActualPath = pwd;
addpath(genpath(ActualPath));

% preset variables
Tel = [0.1e-3 1e-3 5e-3 10e-3];
Tnc_factor = [0.8 1 1.2 1.4];       % *Tel
chi_P = 0:0.05:1;                   % processing deadtime ratio
Fs = [8e3 16e3 24e3];               %sampling frequency
allowedOvershoot = 1.1;             % 10%
s = tf('s');

discopts = c2dOptions('Method','tustin');
discopts.FractDelayApproxOrder = 1;

% location and file name for saving data
t_start = datestr(now,'yymmdd_hhMMss');
currentDir = ActualPath; 
folder_name = 'Data_Save';
if (~exist(folder_name,'dir')), mkdir(folder_name); end
folder_name2 = 'Fig_Save';
if (~exist(folder_name2,'dir')), mkdir(folder_name2); end

% video filename
videofile = [currentDir '\' folder_name2 '\PICurrentControl.avi'];
videoObj = VideoWriter(videofile); open(videoObj);
fileIndex = 0;

%% plot form 1 config

% Initialize figure
hF1  = figure(1); clf
% Figure color, size, posistion. 
hF1.InvertHardcopy = 'off'; hF1.Color = [0.94 0.94 0.94];
% desktop scale 125%: [1280x720]*1.25 = [1600x900].
% desktop scale 150%: [1536x864]*1.25 = [1920x1080].
% desktop scale 150%: [1280x720]*1.5 = [1920x1080].
hF1.Position = [0 0 1280 720];

% create 6 subplot
% tight_subplot(Nh, Nw, gap: between subplot, marg_h: to [bottom top], marg_w: to edge)
[ha, ~] = tight_subplot(2, 3, [0.08 0.03], [0.07 0.07], [0.03 0.01]);

% option for bode plot
opt = bodeoptions; 
opt.FreqUnits = 'Hz'; opt.Grid = 'on'; opt.PhaseVisible = 'off';
opt.XlimMode = 'manual'; opt.YlimMode =  'manual';
opt.Xlim = [1 10e3]; opt.Ylim = [-20 12];

% tex position
title_dim = [0.0825 0.9489 0.8575 0.03888889];
steps_dim = [0.2 0.6 0.0928 0.0922]; 
stepz_dim = [0.2 0.131 0.0928 0.0922];
text_dim = [steps_dim stepz_dim];


%% Running
for l = 1:length(Tnc_factor)
    
    Tnc = Tnc_factor(l)*Tel;
    
    for i = 1:length(Tel)
        
        % title value of plot
        if(exist("title_an", "var")), delete(title_an); end
        str = ['PI Current control in continuous domain (top plots) '...
            'and discrete domain (bottom plots) with '...
            '{\color{red}Tel = ' num2str(Tel(i)*1000) ' ms} '...
            'and {\color{red}Tnc = ' num2str(Tnc(i)*1000) ' ms}'];
        title_an = annotation(hF1,'textbox',title_dim,'FontSize',14,...
            'FontWeight','bold','String',str,'Margin',2,'FitBoxToText','on',...
            'BackgroundColor',[0.94 0.94 0.94],'EdgeColor',[0.94 0.94 0.94]);
        
        KcBW_chi = zeros(7,length(chi_P),length(Fs));      % data variable
        
        for k = 1: length(Fs)       % loop for Fs
            Ts = 1/Fs(k);

            for j = 1:length(chi_P) % loop for processing deadtime, find KcMax, BWsz
                
                d = chi_P(j)*Ts;
                Gos = exp(-d*s)*(1 + 1/Tnc(i)/s)*1/(Tel(i)*s + 1);
                Gos = minreal(Gos);
                % find Kc* max in s domain and z domain
                [KcnMax_vals, KcnMax_valz] = fncFindKmax(Gos,Ts,allowedOvershoot);
                
                % fin bandwidth in s domain
                Gos2 = KcnMax_vals*Gos; 
                Gws = Gos2/(1 + Gos2); Gws = minreal(Gws);
                GwsBWGain3dB_vals = fcnFindBWGws(Gws)/2/pi;
                Sens = 1/(1 + Gos2); Sens = minreal(Sens);
                SenBWGain3dB_vals = fcnFindBWSen(Sens)/2/pi; % BW at Gain-3dB 
                
                % find bandwitdh in z domain
                Gos3 = KcnMax_valz*Gos; 
                Gws3 = Gos3/(1 + Gos3); Gws3 = minreal(Gws3);
                Gwz = c2d(Gws3,Ts,discopts);
%                 Gwz = c2d(Gws,Ts);
                GwsBWGain3dB_valz = fcnFindBWGwz(Gwz)/2/pi;
                Sens3 = 1/(1 + Gos3); Sens3 = minreal(Sens3); 
%                 Senz = c2d(Sens,Ts);
                Senz = c2d(Sens3,Ts,discopts);
                SenBWGain3dB_valz = fcnFindBWSen(Senz)/2/pi; % BW at Gain-3dB 
                
                % save data
                KcBW_chi(:,j,k) = [chi_P(j);...
                    KcnMax_vals; GwsBWGain3dB_vals; SenBWGain3dB_vals;...
                    KcnMax_valz; GwsBWGain3dB_valz; SenBWGain3dB_valz]; 
                
                
                % plot data when chi_P = 0.25 0.5 0.75 1
                if(mod(chi_P(j),0.25) == 0)
                    [ha,an] = plot_form1(hF1,ha, Gws, Sens, Gwz, Senz,KcBW_chi(:,j,k),Ts,text_dim);
                    % save to video file
                    frame = getframe(hF1);
                    writeVideo(videoObj,frame);

                    % delete text for future updat
                    if(exist("an", "var")), delete(an); end
                end

            end
            
        end
        
        % save to csv files   
        fileIndex = fileIndex + 1;
        
        filename = [currentDir '\' folder_name '\' num2str(fileIndex) '_Tel'...
            num2str(Tel(i)*1000,2) 'ms_Tnc' num2str(Tnc(i)*1000,2) 'ms.csv'];
        saveToForm1(filename, KcBW_chi);
        
        filename2 = [currentDir '\' folder_name '\' num2str(fileIndex) '_Tel'...
            num2str(Tel(i)*1000,2) 'ms_Tnc' num2str(Tnc(i)*1000,2) 'ms_2.csv'];
        saveToForm2(filename2, KcBW_chi);

    end
end

close(videoObj);
% implay(videofile);
% system('shutdown -s');
% system('shutdown -a');
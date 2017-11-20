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
% Processing deadtime ration is in step of 0.01
%
% Overshoot is choosen at 10%
%
% Writen by Chuong Nguyen, Nov 2017 
% Version 2.0
% For master thesis at Rosenheim Applied Science University

%% Call tasks
mainSim_GettData;

% mainPlot_KcBw_Tel01ms;
mainPlot_KcBw_Tel1ms;
% mainPlot_KcBw_Tel5ms;
% mainPlot_KcBw_Tel10ms;

% mainPlot_KcBw_TncIs08Tel;
mainPlot_KcBw_TncIs10Tel;
% mainPlot_KcBw_TncIs12Tel;
% mainPlot_KcBw_TncIs14Tel;


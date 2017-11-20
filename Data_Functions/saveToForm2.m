function [] = saveToForm2(filename,data)
%% save data to a csv file
% Original data format
% [8kHz         16kHz        24kHz]     index
%----------------------------------------------
% Xp8[1-11]     Xp16[1-11]   Xp24[1-11] 1
% KncMaxS[1-11]                         2
% GwsBW                                 3
% SensBW                                4
% KncMaxZ                               5
% GwzBW                                 6
% SenzBW                                7

%% extract data
chi_P = data(1,:,1);
KcnMax_s(1,:) = data(2,:,1); KcnMax_s(2,:) = data(2,:,2); KcnMax_s(3,:) = data(2,:,3);
GwsBWGain3dB_s(1,:) = data(3,:,1); GwsBWGain3dB_s(2,:) = data(3,:,1); GwsBWGain3dB_s(3,:) = data(3,:,1);
SenBWGain3dB_s(1,:) = data(4,:,1); SenBWGain3dB_s(2,:) = data(4,:,1); SenBWGain3dB_s(3,:) = data(4,:,1);

KcnMax_z(1,:) = data(5,:,1); KcnMax_z(2,:) = data(5,:,2); KcnMax_z(3,:) = data(5,:,3);
GwsBWGain3dB_z(1,:) = data(6,:,1); GwsBWGain3dB_z(2,:) = data(6,:,1); GwsBWGain3dB_z(3,:) = data(6,:,1);
SenBWGain3dB_z(1,:) = data(7,:,1); SenBWGain3dB_z(2,:) = data(7,:,1); SenBWGain3dB_z(3,:) = data(7,:,1);


%% save to file
fid = fopen(filename,'at');
% fprintf(fid, ['Tel,' num2str(Tel) '\n']);
% fprintf(fid, ['Tnc,' num2str(Tnc) '\n']);

fprintf(fid, 'x_P\n');
dlmwrite(filename,chi_P,'-append');
fprintf(fid, '\n');

%% S domain
fprintf(fid, '\nBandwidth as a function of Gain Kc* at different frequencies');
fprintf(fid,'\nKc* s doamin\nBW s domain\nKc* z domain\nBW z domain\n');

% At frequency
fprintf(fid, '\nat 8kHz\n');
dlmwrite(filename,data(2,:,1),'-append');
dlmwrite(filename,data(3,:,1),'-append');
dlmwrite(filename,data(5,:,1),'-append');
dlmwrite(filename,data(6,:,1),'-append');

% At frequency
fprintf(fid, '\nat 16kHz\n');
dlmwrite(filename,data(2,:,2),'-append');
dlmwrite(filename,data(3,:,2),'-append');
dlmwrite(filename,data(5,:,2),'-append');
dlmwrite(filename,data(6,:,2),'-append');

% At frequency
fprintf(fid, '\nat 24kHz\n');
dlmwrite(filename,data(2,:,3),'-append');
dlmwrite(filename,data(3,:,3),'-append');
dlmwrite(filename,data(5,:,3),'-append');
dlmwrite(filename,data(6,:,3),'-append');


% close file
fclose(fid);
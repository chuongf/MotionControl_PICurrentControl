function [] = saveToForm1(filename,data)
%% save data to a csv file
% [8kHz 16kHz   24kHz]
% Xp8   Xp16    Xp24    1
% KncMaxS ...           2
% GwsBW                 3
% SensBW                4
% KncMaxZ               5
% GwzBW                 6
% SenzBW                7

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
fprintf(fid, 'x_P,');
dlmwrite(filename,chi_P,'-append');
fprintf(fid, '\n');

%% S domain
fprintf(fid, '\nIn s domain\n');

% Kcn max
fprintf(fid, '\nKcn Max\n');
fprintf(fid, '8kHz,');
dlmwrite(filename,KcnMax_s(1,:),'-append');
fprintf(fid, '16kHz,');
dlmwrite(filename,KcnMax_s(2,:),'-append');
fprintf(fid, '24kHz,');
dlmwrite(filename,KcnMax_s(3,:),'-append');

% Gws: BandWidth -3dB at Kmax
fprintf(fid, '\nBandWidth -3dB of Gws at Kcn Max\n');
fprintf(fid, '8kHz,');
dlmwrite(filename,GwsBWGain3dB_s(1,:),'-append');
fprintf(fid, '16kHz,');
dlmwrite(filename,GwsBWGain3dB_s(2,:),'-append');
fprintf(fid, '24kHz,');
dlmwrite(filename,GwsBWGain3dB_s(3,:),'-append');


% Sensitivity: BandWidth -3dB at Kmax
fprintf(fid, '\nBandWidth -3dB of sensitivity function at Kcn Max\n');
fprintf(fid, '8kHz,');
dlmwrite(filename,SenBWGain3dB_s(1,:),'-append');
fprintf(fid, '16kHz,');
dlmwrite(filename,SenBWGain3dB_s(2,:),'-append');
fprintf(fid, '24kHz,');
dlmwrite(filename,SenBWGain3dB_s(3,:),'-append');



%% Z domain
fprintf(fid, '\nIn z domain\n');

% Kcn max
fprintf(fid, '\nKcn Max\n');
fprintf(fid, '8kHz,');
dlmwrite(filename,KcnMax_z(1,:),'-append');
fprintf(fid, '16kHz,');
dlmwrite(filename,KcnMax_z(2,:),'-append');
fprintf(fid, '24kHz,');
dlmwrite(filename,KcnMax_z(3,:),'-append');


% Gws: BandWidth -3dB at Kmax
fprintf(fid, '\nBandWidth -3dB of Gwz at Kcn Max\n');
fprintf(fid, '8kHz,');
dlmwrite(filename,GwsBWGain3dB_z(1,:),'-append');
fprintf(fid, '16kHz,');
dlmwrite(filename,GwsBWGain3dB_z(2,:),'-append');
fprintf(fid, '24kHz,');
dlmwrite(filename,GwsBWGain3dB_z(3,:),'-append');


% Sensitivity: BandWidth -3dB at Kmax
fprintf(fid, '\nBandWidth -3dB of sensitivity function at Kcn Max\n');
fprintf(fid, '8kHz,');
dlmwrite(filename,SenBWGain3dB_z(1,:),'-append');
fprintf(fid, '16kHz,');
dlmwrite(filename,SenBWGain3dB_z(2,:),'-append');
fprintf(fid, '24kHz,');
dlmwrite(filename,SenBWGain3dB_z(3,:),'-append');

% close file
fclose(fid);
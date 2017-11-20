%% function that find BW at gain -3dB of a system
% input: System in z domain
% output: BW in rad/s

function bw = fcnFindBWGwz(Sys)

    [Gain,~,W] = bode(Sys,{10,10e4});
    MaxGain = max(Gain);
    if(MaxGain > 10)     %unstable
%         [~,Index] = find(Gain > 2);
%         bw = W(Index(1));
        bw = 0;
        return;
    end
        
    [~,Index] = find(Gain < 0.707);
    if(isempty(Index))
        bw = W(end);
    else
        f1 = W(Index(1)-1); f3 = W(Index(1));
        g1 = Gain(Index(1)-1); g3 = Gain(Index(1));
        g2 = 0.707; % -3dB
        f2 = f1 + (f3-f1)*(g2 - g1)/(g3-g1);
        bw = f2;
    end
    
end
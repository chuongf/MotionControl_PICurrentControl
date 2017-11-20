function [KcnMax_vals, KcnMax_valz] = fncFindKmax(Gos,Ts,allowedOvershoot)
%% Find maximum value of Kcn that system is stable and has specific overshoot
% Input:    Open loop. e.g.: [PI control]*[System]
%           Sampling inverval
%           Maximum allowed Overshoot
%
% Output:   KcnMax_vals: Maximum gain in s domain
%           KcnMax_valz: Maximum gain in z domain
%
%

%% preset value
S = stepinfo(Gos/(Gos+1));
Kcn = (1:200)*0.1*round(S.RiseTime*1000,1);
lengthKcn = length(Kcn);

discopts = c2dOptions('Method','tustin','FractDelayApproxOrder',1);


%% continuous domain

for i = 1:lengthKcn         %loop for Kcn to find Kcn Max

Gos1 = Kcn(i)*Gos; 
Gws = Gos1/(1 + Gos1); 
SInfo = stepinfo(Gws);

if(SInfo.Peak <= allowedOvershoot) % in range of allowed overshoot
    if(i == lengthKcn) ,KcnMax_vals = Kcn(i); end

else % exceed overshoot  => break
    if(i == 1), KcnMax_vals = Kcn(i-1);
    else , KcnMax_vals = Kcn(i-1); end
    break;
end
end


%% discrete domain
for k = 1:lengthKcn         %loop for Kcn to find Kcn Max

Gos2 = Kcn(k)*Gos; 
Gws = Gos2/(1 + Gos2); 
% Gws = minreal(Gws);

try    
%     Gwz = c2d(Gws,Ts);
    Gwz = c2d(Gws,Ts,discopts);
catch
    if(k == 1), k = 2; end
    KcnMax_valz = Kcn(k-1); % save Kcn Max
    break;
end

ZInfo = stepinfo(Gwz);

if(ZInfo.Peak <= allowedOvershoot) % in range of allowed overshoot
    if(k == lengthKcn), KcnMax_valz = Kcn(k); end

else % exceed overshoot  => break
    if(k == 1), k = 2; end
    KcnMax_valz = Kcn(k-1); % save Kcn Max
    break;
end

end    
    
%end of function


% iMin = 1; iMax = lengthKcn;
% i = floor((iMin + iMax)/2);
% ref = allowedOvershoot;
% err = 0.05;
% 
% for j = 1:lengthKcn
%     Gos1 = Kcn(i)*Gos; 
%     Gws = Gos1/(1 + Gos1); 
%     SInfo = stepinfo(Gws);
% 
%     val = SInfo.Peak;
%     if(val < ref - err)
%         if(iMin == i), KcnMax_vals = Kcn(i); break; end
%         iMin = i;
%         i = floor((iMin + iMax)/2);
%     elseif (val > ref + err)
%         if(iMax == i), KcnMax_vals = Kcn(i); break; end
%         iMax = i;
%         i = ceil((iMin + iMax)/2);
%     else
%         KcnMax_vals = Kcn(i);
%         break;
%     end
%     
% end
% 
% 
% % discrete
% iMin = 1; iMax = lengthKcn;
% i = floor((iMin + iMax)/2);
% 
% 
% for j = 1:lengthKcn
% 
% Gos2 = Kcn(i)*Gos; 
% Gws = Gos2/(1 + Gos2); 
% % Gws = minreal(Gws);
% 
% try    
% %     Gwz = c2d(Gws,Ts);
%     Gwz = c2d(Gws,Ts,discopts);
% catch
%     if(i == 1), i = 2; end
%     KcnMax_valz = Kcn(i-1); % save Kcn Max
%     break;
% end
% 
% ZInfo = stepinfo(Gwz);
% 
% if(ZInfo.Peak <= allowedOvershoot) % in range of allowed overshoot
%     if(i == lengthKcn), KcnMax_valz = Kcn(i); end
% 
% else % exceed overshoot  => break
%     if(i == 1), i = 2; end
%     KcnMax_valz = Kcn(i-1); % save Kcn Max
%     break;
% end
% 
%     
% end
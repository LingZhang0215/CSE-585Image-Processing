%%%%%%%%%%%%%  Function patternRecognition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Find distance between images 
%
% Input Variables:
%     Pecstrum of known image
%     Pecstrum of unknown image
%      
% Returned Results:
%     Distance between two images
%
% Processing Flow:
%     1. Create Cn
%     2. Find distance
%
%  Restrictions/Notes:
%      None
%
%  The following functions are called:
%      None
%
%  Author:      Jiaming Chai, Ling Zhang, Yifei
%  Xiao
%  Date:        2/18/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [distance] = patternRecognition(pecstrum, unknown_pecstrum)   
    cn = [1.0, 0.8, 0.6, 0.4, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1];
    
    distance = 0;
    n = 1;
    while n < 11
        distance = distance + sqrt(cn(n)*(unknown_pecstrum(n) - pecstrum(n))^2);
        n = n + 1;
    end
end
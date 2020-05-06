%%%%%%%%%%%%%  Function complexity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Calculate size distribution U(n), pectrum f(n), and complexity.
%
% Input Variables:
%     Image
%     Image name
%      
% Returned Results:
%     Pecstrum of image
%
% Processing Flow:
%     1. Calculate image size distribution by opening
%     2. Calculate pecstrum and complexity by formula
%
%  Restrictions/Notes:
%      None
%
%  The following functions are called:
%      None
%
%  Author:      Jiaming Chai, Ling Zhang, Yifei
%  Xiao
%  Date:        2/17/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [pecstrum] = complexity(im, name)
    i = 0;
    iter = 0:19;
    
    % find U(r)
    U = zeros(0);
    while i < 20
        se = ones(2*i+1);
        U(i+1) = sum(imopen(im,se), 'all');
%         iter = [iter, i];
%         if(U(end) == 0)
%             break
%         end
        i = i + 1;
    end
    
    % plot setting
    figure
        plot(iter,U, 'r+'), title(sprintf('Size Distribution of %s', name))
        xlabel('r'), ylabel('U(r)')
        set(gca, 'XTick',iter) 
    pause(0.5)
    
    
    % pecstrum
    pecstrum = -1*diff(U)./sum(im,'all');
    
    % remove the last one since len(pecstrum) = len(U) - 1
    iter(end) = [];
    
    figure
        bar(iter, pecstrum), title(sprintf('Pectrum of %s', name))
        xlabel('r'), ylabel('U(r)')
        set(gca, 'XTick',iter) 
    pause(0.5)
    
    

    complexity = -1*sum(pecstrum(pecstrum~=0).*log10(pecstrum(pecstrum~=0)));

    fprintf('%s complexity is %f\n', name, complexity)
end
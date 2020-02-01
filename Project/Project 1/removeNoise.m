%%%%%%%%%%%%%  Function removeNoise %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%       Remove salt-and-pepper noise of the given image.
%
% Input Variables:
%      im       input image
%      row      rows of input image
%      col      columns of input image
%      dtype    different ways to remove noise: average or median
%      
% Returned Results:
%     filt_im   image with removed noise
%
% Processing Flow:
%      1.  Set a new image full of zeros
%      2.  For each valid pixel, 
%             if average remove is used:
%               compute the mean of the 3x3 neighborhood about the
%               pixel and assign this value to the mean image
%             if median remove is used:
%               compute the median of the 3x3 neighborhood about the 
%               pixel and assign this value to the median image
%
%  Restrictions/Notes:
%      Outer border is excluded.  
%
%  The following functions are called:
%      None
%
%  Author:      Yifei Xiao, Ling Zhang, Jiaming Chai
%  Date:        1/27/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [filt_im] = removeNoise(im, row, col, dtype)
    filt_im = zeros(size(im));
    
    % Pad ones as outer border
    % filt_im = padarray(filt_im, [1,1], 1, 'both');
    
    % exclude outer border of image
    for i = 2:row - 1
        for j = 2:col - 1
            neighbour = ...
            [im(i-1, j-1), im(i, j-1), im(i+1, j-1);
             im(i-1, j),   im(i, j),   im(i+1, j);
             im(i-1, j+1), im(i, j+1), im(i+1, j+1)];
         
             if strcmp(dtype, 'average')
                 threshold = 0.5;
                 if mean(neighbour(:)) >= threshold
                     filt_im(i, j) = 1;
                 else
                     filt_im(i, j) = 0;
                 end
             elseif strcmp(dtype, 'median')
                 filt_im(i, j) = median(neighbour(:));
             else
                 error('Wrong type, please use average or median')
             end
        end
    end
    
    % remove padded ones
    % filt_im = filt_im(2:end-1, 2:end-1);
end
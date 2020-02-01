%%%%%%%%%%%%%  Function closeAndOpen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Implement closing and opening to remove noise
%     
%
% Input Variables:
%      im       input image
%      row      rows of input image
%      col      columns of input image
%      
% Returned Results:
%     filt_im   image with removed noise
%
% Processing Flow:
%      1.  Closing: Dilation + Erosion
%      2.  Opening: Erosion + Dilation
%
%  Restrictions/Notes:
%      Implement Opening twice to completely remove noise from original
%      image
%
%  The following functions are called:
%      None
%
%  Author:      Yifei Xiao, Ling Zhang, Jiaming Chai
%  Date:        1/29/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [filt_im] = closeAndOpen(im, row, col)
    filt_im = zeros(size(im));
    filt_im_1 = zeros(size(im));
    filt_im_2 = zeros(size(im));
    
    se = [1 1 1; 1 1 1; 1 1 1]; % white 3x3 structuring element
    
    % Closing:
    % Dilation
    for i = 2: row - 1
        for j = 2: col - 1
            if (im(i-1, j-1) == se(1, 1) || im(i, j-1) == se(1, 2) || im(i+1, j-1) == se(1, 3) ||...
                im(i-1, j)   == se(2, 1) || im(i, j)   == se(2, 2) || im(i+1, j)   == se(2, 3) ||...
                im(i-1, j+1) == se(3, 1) || im(i, j+1) == se(3, 2) || im(i+1, j+1) == se(3, 3))
                filt_im_1(i, j) = 1;
            else
                filt_im_1(i, j) = 0;
            end
        end
    end
    
    %Erosion
    for i = 2: row - 1
        for j = 2: col - 1
            if (im(i-1, j-1) == se(1, 1) && im(i, j-1) == se(1, 2) && im(i+1, j-1) == se(1, 3) &&...
                im(i-1, j)   == se(2, 1) && im(i, j)   == se(2, 2) && im(i+1, j)   == se(2, 3) &&...
                im(i-1, j+1) == se(3, 1) && im(i, j+1) == se(3, 2) && im(i+1, j+1) == se(3, 3))
                filt_im_1(i, j) = 1;
            else
                filt_im_1(i, j) = 0;
            end
        end
    end
    
    figure, imshow(filt_im_1), title('image with closing once')
    
    % Opening 1
    % Erosion
    for i = 2: row - 1
        for j = 2: col - 1
            if (filt_im_1(i-1, j-1) == se(1, 1) && filt_im_1(i, j-1) == se(1, 2) && filt_im_1(i+1, j-1) == se(1, 3) &&...
                filt_im_1(i-1, j)   == se(2, 1) && filt_im_1(i, j)   == se(2, 2) && filt_im_1(i+1, j)   == se(2, 3) &&...
                filt_im_1(i-1, j+1) == se(3, 1) && filt_im_1(i, j+1) == se(3, 2) && filt_im_1(i+1, j+1) == se(3, 3))
                filt_im_2(i, j) = 1;
            else
                filt_im_2(i, j) = 0;
            end
        end
    end
    
    %Dilation
    for i = 2: row - 1
        for j = 2: col - 1
            if (filt_im_1(i-1, j-1) == se(1, 1) || filt_im_1(i, j-1) == se(1, 2) || filt_im_1(i+1, j-1) == se(1, 3) ||...
                filt_im_1(i-1, j)   == se(2, 1) || filt_im_1(i, j)   == se(2, 2) || filt_im_1(i+1, j)   == se(2, 3) ||...
                filt_im_1(i-1, j+1) == se(3, 1) || filt_im_1(i, j+1) == se(3, 2) || filt_im_1(i+1, j+1) == se(3, 3))
                filt_im_2(i, j) = 1;
            else
                filt_im_2(i, j) = 0;
            end
        end
    end
    
    figure, imshow(filt_im_2), title('image with opening once')
    
    % Opening 2
    % Erosion
    for i = 2: row - 1
        for j = 2: col - 1
            if (filt_im_2(i-1, j-1) == se(1, 1) && filt_im_2(i, j-1) == se(1, 2) && filt_im_2(i+1, j-1) == se(1, 3) &&...
                filt_im_2(i-1, j)   == se(2, 1) && filt_im_2(i, j)   == se(2, 2) && filt_im_2(i+1, j)   == se(2, 3) &&...
                filt_im_2(i-1, j+1) == se(3, 1) && filt_im_2(i, j+1) == se(3, 2) && filt_im_2(i+1, j+1) == se(3, 3))
                filt_im(i, j) = 1;
            else
                filt_im(i, j) = 0;
            end
        end
    end
    
    %Dilation
    for i = 2: row - 1
        for j = 2: col - 1
            if (filt_im_2(i-1, j-1) == se(1, 1) || filt_im_2(i, j-1) == se(1, 2) || filt_im_2(i+1, j-1) == se(1, 3) ||...
                filt_im_2(i-1, j)   == se(2, 1) || filt_im_2(i, j)   == se(2, 2) || filt_im_2(i+1, j)   == se(2, 3) ||...
                filt_im_2(i-1, j+1) == se(3, 1) || filt_im_2(i, j+1) == se(3, 2) || filt_im_2(i+1, j+1) == se(3, 3))
                filt_im(i, j) = 1;
            else
                filt_im(i, j) = 0;
            end
        end
    end
    
    figure, imshow(filt_im), title('image with opening twice')
end
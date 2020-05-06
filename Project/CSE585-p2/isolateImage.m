%%%%%%%%%%%%%  Function isolateImage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Isolate target image and find its boundary 
%
% Input Variables:
%     Original image
%     Target image
%     Target image label
%      
% Returned Results:
%     Cropped image with boundary
%
% Processing Flow:
%     1. Find the most left, most right, most top, most bottom pixel of
%     target image
%     2. Crop image
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

function [iso_im] = isolateImage(im,L,label)
    [r, c] = find(L==label);
    rc = [r,c];
    m = length(rc);

    minX = 256;
    maxX = 1;
    minY = 256;
    maxY = 1;

    for i = 1:m
        if rc(i,1) < minX
            minX = rc(i,1);
        end

        if rc(i,1) > maxX
            maxX = rc(i,1);
        end

        if rc(i,2) < minY
            minY = rc(i,2);
        end

        if rc(i,2) > maxY
            maxY = rc(i,2);
        end
    end
    iso_im = double(imcrop(im, [minY minX maxY-minY maxX-minX]));
end
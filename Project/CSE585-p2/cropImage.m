%%%%%%%%%%%%%  Function cropImage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Find target image from original image
%
% Input Variables:
%     Original image
%     Target image label
%      
% Returned Results:
%     Target image
%
% Processing Flow:
%     1. By using built-in function bwconncomp
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

function [new_im] = cropImage(im, label)
    im_ori = im;
    CC = bwconncomp(im);
    im(CC.PixelIdxList{label}) = 0;
    new_im = im_ori - im;
end
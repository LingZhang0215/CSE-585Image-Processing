%%%%%%%%%%%%%  Function main %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Main funtion to put everything together
%
% Input Variables:
%     Original image
%      
% Returned Results:
%     Filtere image with detected circles highlighted
%
% Processing Flow:
%     1. Change the image to black and white by setting threshold.
%     2. Remove noise
%     3. Get structuring elements
%     4. Implement hit or miss transform
%     5. Highlight detected smallest and largest circles on original image
%
%  Restrictions/Notes:
%      None
%
%  The following functions are called:
%      removeNoise.m
%      closeAndOpen.m
%      structuringElement.m
%      HitOrMiss.m
%
%  Author:      Yifei Xiao, Ling Zhang, Jiaming Chai
%  Date:        1/27/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load image 
im = imread('RandomDisks-P10.jpg');

[row, col, channel] = size(im);

%% Remove Noise

% convert image to grey image if it is not
if channel ~= 1
    grey_im = rgb2gray(im);
end

% convert grey image to true black-and-white image
% 0: black, 1: white
bw_im = zeros(size(grey_im));
threshold = 128;
for i = 1:row
    for j = 1:col
        if grey_im(i, j) >= threshold
            bw_im(i, j) = 1;
        else
            bw_im(i, j) = 0;
        end
    end
end

% show image without filter
figure, imshow(bw_im), title('image without filter')

% remove salt-and-pepper noise
% two different approaches: average filt and median filt

mean_filt_im = removeNoise(bw_im, row, col, 'average');
median_filt_im = removeNoise(bw_im, row, col, 'median');

% show two results
figure, imshow(mean_filt_im), title('Remove noise with average filter')
figure, imshow(median_filt_im), title('Remove noise with median filter')

% remove noise by using closing and opening
close_and_open_im = closeAndOpen(bw_im, row, col);

%% Get Structuring Elements

[A_min, A_max, B_min, B_max, min_radius, max_radius] = structuringElement(close_and_open_im);

%% Hit or Miss

% find hit or miss image
[hit_min, hit_max, miss_min, miss_max] = HitOrMiss(close_and_open_im, row, col,...
                                                      A_min, A_max, B_min, B_max);

% hit or miss with image without de-noise
[~, ~, ~, ~] = HitOrMiss(bw_im, row, col,...
                          A_min, A_max, B_min, B_max);
                                                
%% AND logic to find circle in original image
min_circle = double(~hit_min & miss_min);
max_circle = double(~hit_max & miss_max);

% show circle from the original image
figure, imshow(close_and_open_im), title('detected smallest and largest circles')
hold on
angle = 0:pi/365:2*pi;
for i = 1:row
    for j = 1:col
        if min_circle(i, j) == 1
            xunit = min_radius * cos(angle) + j;
            yunit = min_radius * sin(angle) + i;
            plot(xunit, yunit, 'r')
            fill(xunit, yunit, 'r')
        elseif max_circle(i, j) == 1
            xunit = max_radius * cos(angle) + j;
            yunit = max_radius * sin(angle) + i;
            plot(xunit, yunit, 'r')
            fill(xunit, yunit, 'r')
        end
    end
end
hold off

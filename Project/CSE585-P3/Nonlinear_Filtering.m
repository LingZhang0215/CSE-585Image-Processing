%% open image
clc, clear all, close all

im = imread('disk.gif');
figure, imshow(im)
title('Original Image')
pause(0.5)

figure, imhist(im)
title('Gray-scale histogram of original image')
pause(0.5)

im_sub = im(100:150, 50:150);
im_sub_mean = mean(double(im_sub(:)));
im_sub_std = std(double(im_sub(:)));

%% 5*5 mean filter

% use mean5x5.m, very similar to mean3x3 given by professor
meanfilt1_im = mean5x5(im);
figure, imshow(meanfilt1_im)
title('Mean Filter: 1 Iteration')
pause(0.5)

% 5 iterations
meanfilt5_im = im;
for k = 1:5
    meanfilt5_im = mean5x5(meanfilt5_im);
end
figure, imshow(meanfilt5_im)
title('Mean Filter: 5 Iterations')
pause(0.5)

% gray-scale histogram
figure, imhist(meanfilt5_im)
title('Gray-scale histogram of mean filter')
pause(0.5)

% mean and std for interior region
meanfilt5_subset = meanfilt5_im(100:150,50:100);
meanfilt5_mean = mean(double(meanfilt5_subset(:)));
meanfilt5_std = std(double(meanfilt5_subset(:)));


%% 5*5 median filter
% 1 iteration
medfilt1_im = medfilt2(im, [5 5]);
figure, imshow(medfilt1_im)
title('Median Filter: 1 Iteration')
pause(0.5)

% 5 iterations
medfilt5_im = im;
for k = 1:5
    medfilt5_im = medfilt2(medfilt5_im, [5 5]);
end
figure, imshow(medfilt5_im)
title('Median Filter: 5 Iterations')
pause(0.5)

% gray-scale histogram
figure, imhist(medfilt5_im)
title('Gray-scale histogram of median filter')
pause(0.5)

% mean and std for interior region
medfilt5_subset = medfilt5_im(100:150,50:100);
medfilt5_mean = mean(double(medfilt5_subset(:)));
medfilt5_std = std(double(medfilt5_subset(:)));


%% 5*5 alpha-trimmed mean

% 1 iteration
alpha_trim_filt1 = alpha_trim_filt5x5(im);
figure, imshow(alpha_trim_filt1)
title('Alpha-trimmed mean Filter: 1 Iteration')
pause(0.5)

% 5 iteration
alpha_trim_filt5 = im;
for k = 1:5
    alpha_trim_filt5 = alpha_trim_filt5x5(alpha_trim_filt5);
end
figure, imshow(alpha_trim_filt5)
title('Alpha-trimmed mean Filter: 5 Iteration')
pause(0.5)

% gray-scale histogram
figure, imhist(alpha_trim_filt5)
title('Gray-scale histogram of Alpha-trimmed mean filter')
pause(0.5)

% mean and std for interior region
alpha_trim_filt5_subset = alpha_trim_filt5(100:150,50:100);
alpha_trim_filt5_subset_mean = mean(double(alpha_trim_filt5_subset(:)));
alpha_trim_filt5_subset_std = std(double(alpha_trim_filt5_subset(:)));


%% 5*5 sigma filter

% 1 iteration
sigmafilt1_im = sigma_filter5x5(im);
figure, imshow(sigmafilt1_im)
title('Sigma Filter: 1 Iteration')
pause(0.5)

% 5 iterations
sigmafilt5_im = im;
for k = 1:5
    sigmafilt5_im = sigma_filter5x5(sigmafilt5_im);
end
figure, imshow(sigmafilt5_im)
title('Sigma Filter: 5 Iterations')
pause(0.5)

% gray-scale histogram
figure, imhist(sigmafilt5_im)
title('Gray-scale histogram of Sigma filter')
pause(0.5)

% mean and std for interior region
sigmafilt5_subset = sigmafilt5_im(100:150, 50:100);
sigmafilt5_subset_mean = mean(double(sigmafilt5_subset(:)));
sigmafilt5_subset_std = std(double(sigmafilt5_subset(:)));


%% 5×5 symmetric nearest-neighbor mean

% 1 iteration 
neighfilt1_im = near_neigh5x5(im);
figure, imshow(neighfilt1_im)
title('Symmetric Nearest-Neighbor Mean Filter: 1 Iteration')
pause(0.5)

% 5 iterations
neighfilt5_im = im;
for k = 1:5
    neighfilt5_im = near_neigh5x5(neighfilt5_im);
end
figure, imshow(neighfilt5_im)
title('Symmetric Nearest-Neighbor Mean Filter: 5 Iterations')
pause(0.5)

% gray-scale histogram
figure, imhist(neighfilt5_im)
title('Gray-scale histogram of Symmetric Nearest-Neighbor Mean filter')
pause(0.5)

% mean and std for interior region
neighfilt5_subset = neighfilt5_im(100:150, 50:100);
neighfilt5_subset_mean = mean(double(neighfilt5_subset(:)));
neighfilt5_subset_std = std(double(neighfilt5_subset(:)));




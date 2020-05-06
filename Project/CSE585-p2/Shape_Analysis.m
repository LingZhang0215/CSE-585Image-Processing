%%%%%%%%%%%%%  Function Shape_Analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Shape analyze of images 
%
% Input Variables:
%     Original image
%      
% Returned Results:
%     Best match figure from another image
%
% Processing Flow:
%     1. Crop the image
%     2. Find size distribution U(n), pectrum f(n), and complexity
%     3. Find match image
%
%  Restrictions/Notes:
%      None
%
%  The following functions are called:
%      cropImage.m
%      isolateImage.m
%      complexity.m
%      patternRecognition.m
%
%  Author:      Jiaming Chai, Ling Zhang, Yifei
%  Xiao
%  Date:        2/18/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
close all

im = double(imread('match1.gif'));

%Isolate each image
%clover: 1; steer: 2; airplane: 3; spade: 4
crop_clover = cropImage(im, 1);
crop_steer = cropImage(im, 2);
crop_airplane = cropImage(im, 3);
crop_spade = cropImage(im, 4);

clover = isolateImage(crop_clover, crop_clover, 1);
steer = isolateImage(crop_steer, crop_steer, 1);
spade = isolateImage(crop_spade, crop_spade, 1);
airplane = isolateImage(crop_airplane, crop_airplane, 1);

%show image
figure
ax1 = subplot(2,2,1);
    imshow(clover), title('Isolated Clover')
ax2 = subplot(2,2,2);
    imshow(spade), title('Isolated Spade')
ax3 = subplot(2,2,3);
    imshow(steer), title('Isolated Steer')
ax4 = subplot(2,2,4);
    imshow(airplane), title('Isolated Airplane')
pause(0.5)

% Calculate size distribution U(n), pectrum f(n), and complexity
clover_pecstrum = complexity(clover, 'clover');
steer_pecstrum = complexity(steer, 'steer');
spade_pecstrum = complexity(spade, 'spade');
airplane_pecstrum = complexity(airplane, 'airplane');


%% rotate image

im = double(imread('match3.gif'));
%clover: 1; steer: 2; spade: 3; airplane: 4
crop_clover_r = cropImage(im, 1);
crop_steer_r = cropImage(im, 2);
crop_spade_r = cropImage(im, 3);
crop_airplane_r = cropImage(im, 4);



clover_r = isolateImage(crop_clover_r, crop_clover_r, 1);
steer_r = isolateImage(crop_steer_r, crop_steer_r, 1);
spade_r = isolateImage(crop_spade_r, crop_spade_r, 1);
airplane_r = isolateImage(crop_airplane_r, crop_airplane_r, 1);

%show image
figure
ax1 = subplot(2,2,1);
    imshow(clover_r), title('Isolated Rotated Clover')
ax2 = subplot(2,2,2);
    imshow(spade_r), title('Isolated Rotated Spade')
ax3 = subplot(2,2,3);
    imshow(steer_r), title('Isolated Rotated Steer')
ax4 = subplot(2,2,4);
    imshow(airplane_r), title('Isolated Rotated Airplane')
pause(0.5)



clover_r_pecstrum = complexity(clover_r, 'rotated clover');
steer_r_pecstrum = complexity(steer_r, 'rotated steer');
spade_r_pecstrum = complexity(spade_r, 'rotated spade');
airplane_r_pecstrum = complexity(airplane_r, 'rotated airplane');

%% Pattern Recognition

r_pecstrums = reshape([clover_r_pecstrum, steer_r_pecstrum, spade_r_pecstrum, airplane_r_pecstrum], [1, 19, 4]);

% 1: clover, 2: steer, 3: spade, 4: airplane
% clover
disp('clover')
min_distance = Inf;
min_i = Inf;
for i = 1:4
    distance = patternRecognition(clover_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('Clover best match in match3 in %d, with distance %f\n', min_i, min_distance)
figure
    ax1 = subplot(1,2,1);
    imshow(clover), title('Clover in match1')
    ax2 = subplot(1,2,2);
    imshow(clover_r), title('Best match in match3')
pause(0.5)

% steer
disp('steer')
min_distance = Inf;
min_i = Inf;
for i = 1:4
    distance = patternRecognition(steer_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('Steer best match in match3 in %d, with distance %f\n', min_i, min_distance)
figure
    ax1 = subplot(1,2,1);
    imshow(steer), title('Steer in match1')
    ax2 = subplot(1,2,2);
    imshow(steer_r), title('Best match in match3')
pause(0.5)

% spade
disp('spade')
min_distance = Inf;
min_i = Inf;
for i = 1:4
    distance = patternRecognition(spade_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('Spade best match in match3 in %d, with distance %f\n', min_i, min_distance)
figure
    ax1 = subplot(1,2,1);
    imshow(spade), title('Spade in match1')
    ax2 = subplot(1,2,2);
    imshow(spade_r), title('Best match in match3')
pause(0.5)

% airplane
disp('airplane')
min_distance = Inf;
min_i = Inf;
for i = 1:4
    distance = patternRecognition(airplane_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('Airplane best match in match3 in %d, with distance %f\n', min_i, min_distance)
figure
    ax1 = subplot(1,2,1);
    imshow(airplane), title('Airplane in match1')
    ax2 = subplot(1,2,2);
    imshow(airplane_r), title('Best match in match3')
pause(0.5)

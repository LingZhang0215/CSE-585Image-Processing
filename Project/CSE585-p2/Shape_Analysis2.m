%%%%%%%%%%%%%  Function Shape_Analysis2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

im = double(imread('shadow1.gif'));

%Isolate each image
%white_1: 1; black_1: 2; white_2: 3; black_2: 4
%white_3: 6; black_3: 5, white_4: 9; black_4: 10
crop_white_1 = cropImage(im, 1);
crop_black_1 = cropImage(im, 2);
crop_white_2 = cropImage(im, 3);
crop_black_2 = cropImage(im, 4);
crop_white_3 = cropImage(im, 6);
crop_black_3 = cropImage(im, 5);
crop_white_4 = cropImage(im, 9);
crop_black_4 = cropImage(im, 10);


white_1 = isolateImage(crop_white_1, crop_white_1, 1);
black_1 = isolateImage(crop_black_1, crop_black_1, 1);
white_2 = isolateImage(crop_white_2, crop_white_2, 1);
black_2 = isolateImage(crop_black_2, crop_black_2, 1);
white_3 = isolateImage(crop_white_3, crop_white_3, 1);
black_3 = isolateImage(crop_black_3, crop_black_3, 1);
white_4 = isolateImage(crop_white_4, crop_white_4, 1);
black_4 = isolateImage(crop_black_4, crop_black_4, 1);

%show image
figure
ax1 = subplot(3,3,1);
    imshow(white_1), title('Isolated white_1')
ax2 = subplot(3,3,2);
    imshow(black_1), title('Isolated black_1')
ax3 = subplot(3,3,3);
    imshow(white_2), title('Isolated white_2')
ax4 = subplot(3,3,4);
    imshow(black_2), title('Isolated black_2')
ax5 = subplot(3,3,5);
    imshow(white_3), title('Isolated white_3')
ax6 = subplot(3,3,6);
    imshow(black_3), title('Isolated black_3')
ax7 = subplot(3,3,7);
    imshow(white_4), title('Isolated white_4')
ax8 = subplot(3,3,8);
    imshow(black_4), title('Isolated black_4')

% Calculate size distribution U(n), pectrum f(n), and complexity
white_1_pecstrum = complexity(white_1, 'white_1');
white_2_pecstrum = complexity(white_2, 'white_2');
white_3_pecstrum = complexity(white_3, 'white_3');
white_4_pecstrum = complexity(white_4, 'white_4');
 
black_1_pecstrum = complexity(black_1, 'black_1');
black_2_pecstrum = complexity(black_2, 'black_2');
black_3_pecstrum = complexity(black_3, 'black_3');
black_4_pecstrum = complexity(black_4, 'black_4');

%% rotate image
im = double(imread('shadow1rotated.gif'));

%Isolate each image
%black_1_r: 1; white_3_r: 2; white_2_r: 3; black_2_r: 4
%black_3_r: 5; white_4_r: 6, white_1_r: 8; black_4_r: 9
crop_black_1_r = cropImage(im, 1);
crop_white_3_r = cropImage(im, 2);
crop_white_2_r = cropImage(im, 3);
crop_black_2_r = cropImage(im, 4);
crop_black_3_r = cropImage(im, 5);
crop_white_4_r = cropImage(im, 6);
crop_white_1_r = cropImage(im, 8);
crop_black_4_r = cropImage(im, 9);


white_1_r = isolateImage(crop_white_1_r, crop_white_1_r, 1);
black_1_r = isolateImage(crop_black_1_r, crop_black_1_r, 1);
white_2_r = isolateImage(crop_white_2_r, crop_white_2_r, 1);
black_2_r = isolateImage(crop_black_2_r, crop_black_2_r, 1);
white_3_r = isolateImage(crop_white_3_r, crop_white_3_r, 1);
black_3_r = isolateImage(crop_black_3_r, crop_black_3_r, 1);
white_4_r = isolateImage(crop_white_4_r, crop_white_4_r, 1);
black_4_r = isolateImage(crop_black_4_r, crop_black_4_r, 1);

%show image
figure
ax1 = subplot(3,3,1);
    imshow(white_1_r), title('Isolated rotated white_1')
ax2 = subplot(3,3,2);
    imshow(black_1_r), title('Isolated rotated black_1')
ax3 = subplot(3,3,3);
    imshow(white_2_r), title('Isolated rotated white_2')
ax4 = subplot(3,3,4);
    imshow(black_2_r), title('Isolated rotated black_2')
ax5 = subplot(3,3,5);
    imshow(white_3_r), title('Isolated rotated white_3')
ax6 = subplot(3,3,6);
    imshow(black_3_r), title('Isolated rotated black_3')
ax7 = subplot(3,3,7);
    imshow(white_4_r), title('Isolated rotated white_4')
ax8 = subplot(3,3,8);
    imshow(black_4_r), title('Isolated rotated black_4')

    
white_1_r_pecstrum = complexity(white_1_r, 'rotated white_1');
white_2_r_pecstrum = complexity(white_2_r, 'rotated white_2');
white_3_r_pecstrum = complexity(white_3_r, 'rotated white_3');
white_4_r_pecstrum = complexity(white_4_r, 'rotated white_4');

black_1_r_pecstrum = complexity(black_1_r, 'rotated black_1');
black_2_r_pecstrum = complexity(black_2_r, 'rotated black_2');
black_3_r_pecstrum = complexity(black_3_r, 'rotated black_3');
black_4_r_pecstrum = complexity(black_4_r, 'rotated black_4');

%% Pattern Recognition
r_pecstrums = reshape([white_1_r_pecstrum, white_2_r_pecstrum, white_3_r_pecstrum, white_4_r_pecstrum, ...
    black_1_r_pecstrum, black_2_r_pecstrum, black_3_r_pecstrum, black_4_r_pecstrum], [1, 19, 8]);


% white 1
disp('white_1')
min_distance = Inf;
min_i = Inf;
for i = 1:8
    distance = patternRecognition(white_1_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('White_1 best match in shadow1rotated in %d, with distance %f\n', min_i, min_distance)

% white 2
disp('white_2')
min_distance = Inf;
min_i = Inf;
for i = 1:8
    distance = patternRecognition(white_2_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('White_2 best match in shadow1rotated in %d, with distance %f\n', min_i, min_distance)

% white 3
disp('white_3')
min_distance = Inf;
min_i = Inf;
for i = 1:8
    distance = patternRecognition(white_3_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('White_3 best match in shadow1rotated in %d, with distance %f\n', min_i, min_distance)

% white 4
disp('white_4')
min_distance = Inf;
min_i = Inf;
for i = 1:8
    distance = patternRecognition(white_4_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('White_4 best match in shadow1rotated in %d, with distance %f\n', min_i, min_distance)

% black 1
disp('black_1')
min_distance = Inf;
min_i = Inf;
for i = 1:8
    distance = patternRecognition(black_1_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('Black_1 best match in shadow1rotated in %d, with distance %f\n', min_i, min_distance)

% black 2
disp('black_2')
min_distance = Inf;
min_i = Inf;
for i = 1:8
    distance = patternRecognition(black_2_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('Black_2 best match in shadow1rotated in %d, with distance %f\n', min_i, min_distance)

% black 3
disp('black_3')
min_distance = Inf;
min_i = Inf;
for i = 1:8
    distance = patternRecognition(black_3_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('Black_3 best match in shadow1rotated in %d, with distance %f\n', min_i, min_distance)

% black 4
disp('black_4')
min_distance = Inf;
min_i = Inf;
for i = 1:8
    distance = patternRecognition(black_4_pecstrum, r_pecstrums(:,:,i));
    fprintf('%d has distance %f\n', i, distance)
    if distance < min_distance
        min_distance = distance;
        min_i = i;
    end
end
fprintf('Black_4 best match in shadow1rotated in %d, with distance %f\n', min_i, min_distance)
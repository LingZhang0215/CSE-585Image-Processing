%% Load image
clc, clear, close all
im = imread('d9d77.gif');
% convert to binary
im_bin = imbinarize(im);
figure
imshow(im_bin), title('Original Texture')
pause(0.1)

%% Parameters
F = 0.063;
theta = 60;
sigma_1=36;

[row, col] = size(im_bin);
i_1 = zeros(row, col);
i_2 = zeros(row, col);
m = zeros(row, col);
%% Gabor filter, L18-4
% Step 1
for x = 1 + 2*sigma_1: row - 2*sigma_1
    for y = 1: col
        for c = x - 2*sigma_1: x + 2*sigma_1 % filter size
            i_1(x,y) = i_1(x,y) + im_bin(c,y)*h1(x - c, sigma_1, F, theta);
        end
    end
end

% Step 2
for x = 1: row
    for y = 1 + 2*sigma_1: col - 2*sigma_1
        for c = y - 2*sigma_1: y + 2*sigma_1
            i_2(x,y) = i_2(x,y) + i_1(x,c)*h2(y - c, sigma_1, F, theta);
        end
    end
end

% Step 3
for x = 1:row
    for y = 1:col
        m(x,y) = abs(i_2(x,y));
    end
end

%% Gabor filter plot
[X,Y] = meshgrid(1:row, 1:col);
figure
mesh(m), title('Gabor filter')

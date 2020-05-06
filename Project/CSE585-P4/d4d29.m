%% Load image
clc, clear, close all
im = imread('d4d29.gif');
% convert to binary
im_bin = imbinarize(im);
figure
imshow(im_bin), title('Original Texture')
pause(0.1)

%% Parameters

F = 0.6038;
theta = -50.5;
sigma_1 = 8;
sigma_2 = 9;
smooth_sigma = 40;

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
mesh(X,Y,m), title('Gabor filter')

%% smoothing filter
i_prime = zeros(row, col);
m_prime = zeros(row, col);

for x = 1 + 2*smooth_sigma: row - 2*smooth_sigma
    for y = 1: col
        for c = x - 2*smooth_sigma: x + 2*smooth_sigma % filter size
            g = 1/(2*pi*smooth_sigma)*exp(-0.5*(smooth_sigma/(x-c))^2);
            i_prime(x,y) = i_prime(x,y) + m(c,y)*g;
        end
    end
end

for x = 1: row
    for y = 1 + 2*smooth_sigma: col - 2*smooth_sigma
        for c = y - 2*smooth_sigma: y + 2*smooth_sigma
            g = 1/smooth_sigma*exp(-0.5*(smooth_sigma/(y-c))^2);
            m_prime(x,y) = m_prime(x,y) + i_prime(x,c)*g;
        end
    end
end

%% smoothing filter plot
m_prime_new = m_prime(1 + 2*smooth_sigma:row - 2*smooth_sigma, 1 + 2*smooth_sigma:col - 2*smooth_sigma);
figure
mesh(m_prime_new), title('Smoothing filter')

%%
new_im = im_bin(1 + 2*sigma_2:row - 2*sigma_2, 1 + 2*sigma_2:col - 2*sigma_2);
[M,N] = size(new_im);
im_2 = zeros(M,N);
for x = 1:M
    for y = 1:N
        if t == 2
            if(m_prime_new(x,y) > 0.0273)
                im_2(x,y) = 1;
            end
        elseif t == 1
            if(m_prime_new(x,y) > 0.023)
                im_2(x,y) = 1;
            end
        end
    end
end
figure
imshowpair(im_2, new_im);


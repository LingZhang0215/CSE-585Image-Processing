%% Load image
clc, clear, close all
im = imread('d9d77.gif');
%t = 2; % 1 means texture 1, 2 means texture 2
% convert to binary
im_bin = imbinarize(im);
figure
imshow(im_bin), title('Original Texture')
pause(0.1)

%% Parameters
% if t == 2
%     F = 0.059;
%     theta = 135;
%     sigma_1 = 8;  % for Gabor filter
%     sigma_2 = 24; % for smoothing filter
% end
% 
% if t == 1
%     F = 0.042;
%     theta = 0;
%     sigma_1 = 24;
%     sigma_2 = 24;
% end
F = 0.063;
theta = 60;
sigma_1 = 36;
sigma_2 = 36;
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
for x = 1 + 2*sigma_1 : row - 2*sigma_1
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
figure
mesh(m), title('Gabor filter')

%% smoothing filter
i_prime = zeros(row, col);
m_prime = zeros(row, col);

for x = 1 + 2*sigma_2: row - 2*sigma_2
    for y = 1: col
        for c = x - 2*sigma_2: x + 2*sigma_2 % filter size
            g = 1/(2*pi*sigma_2)*exp(-0.5*(sigma_2/(x-c))^2);
            i_prime(x,y) = i_prime(x,y) + m(c,y)*g;
        end
    end
end

for x = 1 + 2*sigma_2: row - 2*sigma_2
    for y = 1 + 2*sigma_2: col - 2*sigma_2
        for c = y - 2*sigma_2: y + 2*sigma_2
            g = 1/sigma_2*exp(-0.5*(sigma_2/(y-c))^2);
            m_prime(x,y) = m_prime(x,y) + i_prime(x,c)*g;
        end
    end
end

%% smoothing filter plot
m_prime_new = m_prime(1 + 2*sigma_2:row - 2*sigma_2, 1 + 2*sigma_2:col - 2*sigma_2);
figure
mesh(m_prime_new), title('Smoothing filter')

%%
new_im = im_bin(1 + 2*sigma_2:row - 2*sigma_2, 1 + 2*sigma_2:col - 2*sigma_2);
[M,N] = size(new_im);
im_2 = zeros(M,N);
for x = 1:M
    for y = 1:N
        if t == 2
            if(m_prime_new(x,y) > 0.012)
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


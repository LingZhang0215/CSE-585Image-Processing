%%%%%%%%%%%%%  Function HitOrMiss %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Implement hit or miss transform 
%
% Input Variables:
%     im           input image
%     row          rows of input image
%     col          columns of input image
%     A_min        structuring element A for smallest circles
%     B_min        structuring element B for smallest circles
%     A_max        structuring element A for largest circles
%     B_max        structuring element B for largest circles
%      
% Returned Results:
%     hit_min      image which shows smallest circles hitted by structuring element A
%     hit_max      image which shows largest circles hitted by structuring element A
%     miss_min     image which shows smallest circles missed by structuring element B
%     miss_max     image which shows largest circles missed by structuring element B
%
% Processing Flow:
%      1.  Move structuring elements through image to detect hit and miss
%      2.  For hit: sum of the detected area should be zero (all black)
%      3.  For miss: sum of the detected area should be less or equal to
%                    structuring element window area.
%
%  Restrictions/Notes:
%      None
%
%  The following functions are called:
%      None
%
%  Author:      Yifei Xiao, Ling Zhang, Jiaming Chai
%  Date:        1/28/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [hit_min, hit_max, miss_min, miss_max] = HitOrMiss(im, row, col, A_min, A_max, B_min, B_max)
    % Hit: Move Structuring Element through filtered image to find hits
    hit_min = ones(size(im));
     cr = length(A_min) / 2; % check radius
     for i = 1 + cr: row - cr - 1
         for j = 1 + cr: col - cr - 1
             check_area = im(i - cr: i + cr, j - cr: j + cr);
             % check if it hits: if it hits, sum of the area should be zero
             if sum(check_area, 'all') == 0
                 hit_min(i,j) = 0;
             end
         end
     end
     figure, imshow(hit_min), title('hit by smallest structuring element')
     
     % Miss: Move Structuring Element through complemented filtered image to find hits
     miss_min = zeros(size(im));
     cr = (length(B_min) - 1) / 2;
     for i = 1 + cr: row - cr -1
         for j = 1 + cr: col - cr - 1
             check_area = ~im(i - cr: i + cr, j - cr: j + cr);
             % check if it misses: if it misses, check area white should be less
             % or equal to window area white
             window_area = double(B_min & check_area);
             if sum(check_area, 'all') <= sum(window_area, 'all')
                 miss_min(i,j) = 1;
             end
         end
     end
     figure, imshow(miss_min), title('miss by smallest structuring element')


     hit_max = ones(size(im));
     cr = length(A_max) / 2;
     for i = 1 + cr: row - cr - 1
         for j = 1 + cr: col - cr - 1
             check_area = im(i - cr: i + cr, j - cr: j + cr);
             % check if it hits: if it hits, sum of the area should be zero
             if sum(check_area, 'all') == 0
                 hit_max(i,j) = 0;
             end
         end
     end
     figure, imshow(hit_max), title('hit by largest structuring element')


     % Miss: Move Structuring Element through complemented filtered image to find hits
     miss_min = zeros(size(im));
     cr = (length(B_min) - 1) / 2;
     for i = 1 + cr: row - cr -1
         for j = 1 + cr: col - cr - 1
             check_area = ~im(i - cr: i + cr, j - cr: j + cr);
             % check if it misses: if it misses, check area white should be less
             % or equal to window area white
             window_area = double(B_min & check_area);
             if sum(check_area, 'all') <= sum(window_area, 'all')
                 miss_min(i,j) = 1;
             end
         end
     end
     figure, imshow(miss_min), title('miss by smallest structuring element')

 
     miss_max = zeros(size(im));
     cr = (length(B_max) - 1) / 2;
     for i = 1 + cr: row - cr -1
         for j = 1 + cr: col - cr - 1
             check_area = ~im(i - cr: i + cr, j - cr: j + cr);
             % check if it misses: if it misses, check area white should be less
             % or equal to window area white
             window_area = double(B_max & check_area);
             if sum(check_area, 'all') <= sum(window_area, 'all')
                 miss_max(i,j) = 1;
             end
         end
     end
     figure, imshow(miss_max), title('miss by largest structuring element')
end
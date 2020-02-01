%%%%%%%%%%%%%  Function structuringElement %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%     Get structuring elements A and B in order to to hit or miss
%     transform
%
% Input Variables:
%     im           input image
%      
% Returned Results:
%     A_min        structuring element A for smallest circles
%     B_min        structuring element B for smallest circles
%     A_max        structuring element A for largest circles
%     B_max        structuring element B for largest circles
%     min_radius   radius of smallest circle, for later usage
%     max_radius   radius of largest circle, for later usage
%
% Processing Flow:
%      1.  Put all circles in the image into five groups
%      2.  Find radius of smallest and largest circle
%      3.  Create structuring elements base on the radius found in step 2
%
%  Restrictions/Notes:
%      Structuring elements are square-shaped, not circle shaped, but they
%      satisfy hit or miss transform requirement.
%
%  The following functions are called:
%      None
%
%  Author:      Yifei Xiao, Ling Zhang, Jiaming Chai
%  Date:        1/28/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A_min, A_max, B_min, B_max, min_radius, max_radius] = structuringElement(im)
    % find circles on plot
    % https://www.mathworks.com/help/images/ref/regionprops.html
    stats = regionprops('table', ~im, 'Centroid',...
        'MajoraxisLength', 'MinoraxisLength');
    diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radii = diameters/2;

    % cluster circles to five sets based on their radii
    set1 = [];
    set2 = [];
    set3 = [];
    set4 = [];
    set5 = [];

    set_ids = kmeans(radii(2:end), 5); % remove the first element since it is the whole image
    for i = 1:length(set_ids)
        switch set_ids(i)
            case 1
                set1 = [set1, radii(i+1)];
            case 2
                set2 = [set2, radii(i+1)];
            case 3
                set3 = [set3, radii(i+1)];
            case 4
                set4 = [set4, radii(i+1)];
            case 5
                set5 = [set5, radii(i+1)];
        end    
    end

    % In order to detect smallest and largest sets of circles,
    % we need to generate structuring elements with radius of
    % the smallest radius of the smallest set, 
    % and the largest radius of the largest set

    min_sets = sort([min(set1), min(set2), min(set3), min(set4), min(set5)]);
    max_sets = sort([max(set1), max(set2), max(set3), max(set4), max(set5)]);

    min_radius = min_sets(1);
    max_radius = max_sets(end);

    % Since it is very hard to create circle in matlab,
    % we use square as our structuring elements.

    A_min = zeros(floor(min_radius/sqrt(2))*2);
    A_max = zeros(floor(max_radius/sqrt(2))*2);

    B_min = padarray(ones(ceil(min_radius)*2 + 1), [3,3], 0, 'both'); % make it odd for miss movement
    B_max = padarray(ones(ceil(max_radius)*2 + 1), [3,3], 0, 'both');

    figure
    ax1 = subplot(2,2,1);
        imshow(A_min), title('minimum structuring element A')
    ax2 = subplot(2,2,2);
        imshow(B_min), title('minimum structuring element B')
    ax3 = subplot(2,2,3);
        imshow(A_max), title('maximum structuring element A')
    ax4 = subplot(2,2,4);
        imshow(B_max), title('maximum structuring element B')
    linkaxes([ax1, ax2, ax3, ax4], 'y')
end
function [alpha_trim_filt] = alpha_trim_filt5x5(im)
    % https://www.mathworks.com/help/images/ref/ordfilt2.html
    im = uint16(im);
    alpha = 0.25;
    domain = ones(5,5);
    n = length(domain(:));
    coeff = 1/(n - 2*floor(alpha*n));
    low = floor(alpha*n) + 1;
    high = n - floor(alpha*n);
    order = low:high;
    
    alpha_trim_filt = zeros(size(im));
    for i = 1:length(order)
        alpha_trim_filt = alpha_trim_filt + double(ordfilt2(im, order(i), domain));
    end
    alpha_trim_filt = coeff * alpha_trim_filt;
    
    alpha_trim_filt = uint8(alpha_trim_filt);
end
function [sigma_im] = sigma_filter5x5(im)

    im = uint16(im);
    
    sigma = 20;
    
    [row, col] = size(im);
    
    sigma_im = im;
    for i = 3: row - 2
        for j = 3: col - 2
            domain = im(i - 2: i + 2, j - 2: j + 2);
            diff = abs(domain - im(i, j));
            idx = diff <= 2*sigma;
            keep_im = domain(idx);
            y_hat = mean(keep_im(:));
            sigma_im(i,j) = y_hat;
        end
    end
    
    sigma_im = uint8(sigma_im);
end
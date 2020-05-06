function [mean_filt] = mean5x5(im)
    [row, col] = size(im);

    % empty image
    fzero = zeros(row, col);

    for x = 1 : row        
        for y = 1 : col    
            mean_filt(x,y) = fzero(x,y);
        end
    end

    g = uint16(im);

    xlo = 3;   
    xhi = row-2; 
    ylo = 3;  
    yhi = col-2;

    for x = xlo : xhi        
        for y = ylo : yhi  
            for i = -2 : 2
                for j = -2 : 2  
                    mean_filt(x,y) = g(x-i,y-j) + mean_filt(x,y);
                end
            end
            mean_filt(x,y) = mean_filt(x,y) / 25.;
        end
    end

    mean_filt = uint8(mean_filt);
end
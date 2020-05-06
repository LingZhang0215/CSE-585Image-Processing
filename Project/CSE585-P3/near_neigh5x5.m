function [neigh_im] = near_neigh5x5(im)

    im = uint16(im);
    
    [row, col] = size(im);
    
    neigh_im = im;
    
    for k = 3:row - 2
        for l = 3: col - 2
            domain = im(k - 2: k + 2, l - 2: l + 2);
            center = domain(3,3);
            min_vals = [];
            for i = 0:2
                for j = 0:2
                    pair = [domain(3 - i, 3 - j), domain(3 + i, 3 + j)];
                    diff = abs(pair - center);
                    [~, idx] = min(diff);
                    min_vals = [min_vals, pair(idx)];
                end
            end
            neigh_im(k, l) = mean(min_vals);
        end
    end
    
    neigh_im = uint8(neigh_im);
end
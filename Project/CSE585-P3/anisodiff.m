function d = anisodiff(im, n, k, lambda, f)

im = double(im);
[r,c] = size(im);
d = im;

for i = 1:n
    
    dl = zeros(r+2, c+2);
    dl(2:r+1, 2:c+1) = d;
    
    Top = dl(1:r,2:c+1)-d;
    Bot = dl(3:r+2,2:c+1)-d;
    Left = dl(2:r+1,3:c+2)-d;
    Right = dl(2:r+1,1:c)-d;
    
    if f == 1
        cN = exp(-(Top/k).^2);
        cS = exp(-(Bot/k).^2);
        cE = exp(-(Left/k).^2);
        cW = exp(-(Right/k).^2);
        
    elseif f == 2
        cN = 1./(1 + (Top/k).^2);
        cS = 1./(1 + (Bot/k).^2);
        cE = 1./(1 + (Left/k).^2);
        cW = 1./(1 + (Right/k).^2);
        
    end
    
    d = d + lambda*(cN.*Top + cS.*Bot + cE.*Left + cW.*Right);
    
    
end

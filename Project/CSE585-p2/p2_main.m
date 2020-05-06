% Taking the index of the SE. 
clear
B1 = [0 0; -1 1; 0 1; 1 1];
B2 = [0 0; -1 0; -1 1; 0 1];
B3 = [0 0; -1 -1; -1 0; -1 1];
B4 = [0 0; -1 0; -1 -1; 0 -1];

B=reshape([B1 B2 B3 B4 -B1 -B2 -B3 -B4], [4 2 8]);
%im = imread('penn256.gif');
im = imread('bear.gif');
i=0;
while 1
    new_im=im;
    for j=1:8
         new_im=homotopic_skeleton(new_im, B(:,:,j));
    end
    if (i==100 || isequal(im, new_im))
        i
        break
    end
    sum(new_im,'all')
    i=i+1;
    im=new_im;
end
imshow(new_im)



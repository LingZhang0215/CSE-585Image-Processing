k=50;
f=1;

figure('position', [0 0 512 1024])
for i=[0 5 20 100]
    
    im=imread('Images/cwheelnoise.gif');
    d_im=adiff(im, i, k, 0.25, f)/255;
    [c, b]=imhist(d_im);
%     saveas(gcf, sprintf('his.png'));
    
    tiledlayout(3, 2)
    
    nexttile
    imshow(d_im)
    title('Filtered Image');
    
    nexttile
    d_im(d_im<0.4)=1;
    imshow(d_im)
    title('Segmented Image');
    
    nexttile([1 2])
    %imshow(imread('his.png'))
    bar(b, c)
    title('Histogram')
    
    nexttile([1 2])
    p=d_im(:, 128);
    x=(1:256);
    
    plot(x, p)
    xlim([1 256]);
    title('Plot y=128');
    
    saveas(gcf,sprintf('w-%d-%d.jpg',f,i))
end
%%
k=50;
f=1;
for i = [0 5 20 100]
    im=imread('Images/cameraman.tif');
    d_im=adiff(im, i, k, 0.25, f)/255;
    imshow(d_im)
    saveas(gcf,sprintf('c-%d-%d.jpg',f,i))
end
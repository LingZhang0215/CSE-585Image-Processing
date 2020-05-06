function new_im = homotopic_skeleton(im, B)

Bf=B;
Bg=-B(2:end, :);
pim=zeros(258,258);
pim(2:257, 2:257)=im;

hit = zeros(size(pim));
 for i = 2: 257
     for j = 2: 257
%        Flags for all match with the SE. 
         all = 1;
%        loop over the indices
         for m=1:length(Bf)
             all = pim(i+Bf(m, 1),j+Bf(m,2)) & all;
         end
         if (all)
             hit(i,j) = 1;
         else
             hit(i,j) = 0;
         end
     end
 end

 pim(2:257,2:257)=~im;
 miss = zeros(size(pim));
 for i = 2: 257
     for j = 2: 257
%        Flags for all match with the SE. 
         all = 1;
%        loop over the indices
         for m=1:length(Bg)
             all = pim(i+Bg(m, 1),j+Bg(m,2)) & all;
         end
         if (all)
             miss(i,j) = 1;
         else
             miss(i,j) = 0;
         end       
     end
 end
hom = hit & miss;
new_im = xor(im,hom(2:257,2:257));
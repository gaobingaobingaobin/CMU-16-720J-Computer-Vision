% Wang luting
% Q 5.2
% 2015

function [H2to1, panoImg] = q5_2(img1, img2, pts)

p1 = pts(1:2, :);
p2 = pts(3:4, :);
H2to1 = computeH(p1, p2);

%calculating M
a = H2to1*[1; 1; 1];
a(1) = a(1)./a(3);
a(2) = a(2)./a(3);
b = H2to1*[1608; 1; 1];
b(1) = b(1)./b(3);
b(2) = b(2)./b(3);
c = H2to1*[1; 1068; 1];
c(1) = c(1)./c(3);
c(2) = c(2)./c(3);
d = H2to1*[1608; 1068; 1];
d(1) = d(1)./d(3);
d(2) = d(2)./d(3);
minx = min([a(1),b(1),c(1), d(1)]);
maxx = max([a(1),b(1),c(1), d(1)]);
miny = min([a(2),b(2),c(2), d(2)]);
maxy = max([a(2),b(2),c(2), d(2)]);

l = ceil(maxx);
h = ceil(maxy - miny);

out_size = [1280 1280];
f = out_size(2)/l;
out_size(1) = ceil(f*h);
delta = ceil(abs((miny)));

out_size = [1280 1280];
f = out_size(2)/l;
M = [f, 0, 0; 0, f, f*delta+1; 0, 0, 1];
out_size(1) = ceil(f*h);

warp_im1=warpH(img1, M, out_size);
warp_im2=warpH(img2, M*H2to1, out_size);
panoImg = warp_im2;

for k = 1: 3
    for i = ceil(f*delta)+10: ceil(f*(delta+1068))
        for j = 1:f*1608
            panoImg(i, j, k) = warp_im1(i, j, k);
        end
    end
end







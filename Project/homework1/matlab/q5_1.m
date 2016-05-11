% Wang luting
% Q 5.1
% 2015

function [H2to1,warpedImg,panoImg]= q5_1(im1,im2,pts)

p1 = pts(1:2, :);
p2 = pts(3:4, :);

H2to1 = computeH(p1, p2);
save('q5_1.mat', 'H2to1');

p3= [p2(1, :); p2(2, :); ones(1, 1048)];
p4 = H2to1*p3;
p4(1, :) = p4(1, :)./p4(3, :);
p4(2, :) = p4(2, :)./p4(3, :);
p4 = p4(1:2,:);
save('q5_1_warpedFeatures.mat', 'p4');

%calculating the errors
p5 = p4(1, :) - p1(1, :);
p6 = p4(2, :) - p1(2, :);
error = sqrt((sum(p5.^2) + sum(p6.^2))/1048)

% p3 = [p2(1, :); p2(2, :); ones(1, 1048)]
% imsize = size(im1);
% 
% %a = H2to1*[1; 1; 1]
% %b =  H2to1*[imsize(1); 1; 1]
% c =  H2to1*[imsize(2); 1 ;1]
% miny = c(1)/c(3);
% x1 = c(2)/c(3);
% d =  H2to1*[imsize(2); imsize(1) ;1]
% maxy = d(1)/d(3);
% x2 = d(2)/d(3); 
% h = ceil(maxy - miny);
% l = ceil(max(x1, x2));
% 
% f = 1280/l;


%out_size = size(im1);
out_size = [size(im1,1),3000];
warpedImg = warpH(im2, H2to1, out_size,0);
save('q5_1.jpg', 'warpedImg');

panoImg = warpedImg;

for k = 1: size(im1, 3)
for i = 1: size(im1, 1)
    for j = 1:size(im1, 2)
        panoImg(i, j, k) = im1(i, j, k);
    end
end
end

save('q5_1_pan.jpg', 'panoImg');











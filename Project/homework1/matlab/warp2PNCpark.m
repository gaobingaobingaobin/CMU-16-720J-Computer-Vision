% Wang luting
% Q 4.2
% 2015

function [img_yourname_warped, img_PNCpark_yourname] = warp2PNCpark(img_PNCpark, img_yourname, p1, p2)

H = computeH(p1, p2);

out_size =  size(img_PNCpark);


img_yourname_warped = warpH(img_yourname, H, out_size,0);

out = img_yourname_warped;


for k = 1:out_size(3)
    for i = 1 : out_size(1)
        for j = 1: out_size(2)
            if( out(i, j, k) == 0)
                out(i, j, k) = img_PNCpark(i, j, k);
            end
        end
    end
end


img_PNCpark_yourname = out;

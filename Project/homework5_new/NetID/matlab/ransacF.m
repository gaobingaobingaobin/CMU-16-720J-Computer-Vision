function [F, inliers] = ransacF(pts1, pts2, normalization_constant)

numOfConresponse = size(pts1,2);
th = 0.01;
m = 3000;
maxNumOfInliers = 0; %inilize 

for j = 1:m
    temp = randperm(numOfConresponse);
    random_index = temp(1:7);
    selected_pts1 = pts1(:, random_index);
    selected_pts2 = pts2(:, random_index);

    temp_F = sevenpoint_norm(selected_pts1, selected_pts2, normalization_constant);
    
    numOfF = length(temp_F);
    for k = 1:numOfF
        temp_inliers = [];
        for i = 1 : numOfConresponse
            p1 = [pts1(:, i);1]; 
            p2 = [pts2(:, i);1]; 
            eline = temp_F{k}'*p2;
            dis = abs(p1'*temp_F{k}'*p2/(sqrt(sum(eline.^2))));
            if(dis < th)
                temp_inliers = [temp_inliers,i];
            end
        end
        numOfInliers = size(temp_inliers, 2);
        if(numOfInliers > maxNumOfInliers)
            maxNumOfInliers = numOfInliers;
            inliers = temp_inliers;
            F = temp_F{k};
        end
    end  
end

end


        
function [plane,new_inliers] = ransacF_plane(pts, th)

numOfPoints = size(pts,2);
m = 3000;
maxNumOfInliers = 0;
for j = 1:m
    temp = randperm(numOfPoints);
    random_index = temp(1:3);
    selected_pts = pts(:, random_index);

    temp_plane = genPlane(selected_pts(:,1)',  selected_pts(:,2)', selected_pts(:,3)');
    temp_inliers = [];
    
    for i = 1:numOfPoints
        point = pts(:, i)';
        dis =  abs(dot([point 1],temp_plane))/norm(temp_plane(1:3));
        if(dis < th)
             temp_inliers = [temp_inliers,i];
        end  
    end
    
    numOfInliers = size(temp_inliers, 2);
    if(numOfInliers > maxNumOfInliers)
        maxNumOfInliers = numOfInliers;
        new_inliers = temp_inliers;
        plane = temp_plane;
    end  
end

end
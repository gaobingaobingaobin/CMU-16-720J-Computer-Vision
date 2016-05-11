function genNovelView
	addpath(genpath('.'));
	load('data/K.mat'); %intrinsic parameters K
	i1 = imread('data/i1.jpg');
	i2 = imread('data/i2.jpg');
    load('noisy_correspondences.mat');

    normalization_constant = max(max(size(i1),size(i2)));
    [F, inliers] = ransacF(pts1, pts2, normalization_constant);

    pts1 = pts1(:, inliers);
    pts2 = pts2(:, inliers);
    M1 = K*eye(3, 4);
	M2 = camera2(F, K, K, pts1, pts2);
    P = triangulate(M1,pts1, M2, pts2);
    
    th = 0.05;
    [plane1,inliers1] = ransacF_plane(P, th);
    
    P(:,inliers1) = [];
    points_plane2 = P;
    th = 0.03;
    [plane2,inliers2] = ransacF_plane(points_plane2, th);

    frame = drawNovelView(plane1', plane2', M1);      %novel view 1
    imshow(frame);
   
    theta = 40*pi/180;
    R = [1, 0, 0; 0, cos(theta), -sin(theta); 0, sin(theta), cos(theta)];
    t = [1;2;3];
    M3 = K*[R, t];
    frame = drawNovelView(plane1', plane2', M3);    %novel view 2
    imshow(frame);
   
    

end


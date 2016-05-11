addpath('./lib', './data');
load('clean_correspondences.mat');
%load('noisy_correspondences.mat');
I1 = imread('i1.jpg');
I2 = imread('i2.jpg');

normalization_constant = max(max(size(I1),size(I2)));
pts1 = pts1(:, 1:7);
pts2 = pts2(:, 1:7);
F = sevenpoint_norm(pts1, pts2, normalization_constant);

numOfF = size(F, 2);

 if(numOfF == 1)
     displayEpipolarF(I1, I2, F);
else
    for i = 1:3
        fprintf('This is the %d\n F', i);
        displayEpipolarF(I1, I2, F{i});
    end

end
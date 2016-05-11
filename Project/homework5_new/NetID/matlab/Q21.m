addpath('./lib', './data');
load('clean_correspondences.mat');
%load('noisy_correspondences.mat');
I1 = imread('i1.jpg');
I2 = imread('i2.jpg');

normalization_constant = max(max(size(I1),size(I2)));
F = eightpoint_norm(pts1, pts2, normalization_constant);

%F = F * normalization_constant;
displayEpipolarF(I1, I2, F);
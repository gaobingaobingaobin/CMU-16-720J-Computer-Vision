%% setting path and load model
addpath(genpath('../utils'));
addpath(genpath('../lib/dpm'));
load('../../data/bus_dpm.mat');

%% Object detection via DPMs
I = imread('q42_test.jpg');
detectionBoxes = imgdetect(I,model);
figure; showboxes(I,  detectionBoxes);      %% show detected bounding boxes.
%saveas(gcf,'q22_result.jpg')

%% Non-Maximum suppression
bestBBox = nms(detectionBoxes,100,3);
figure; hold on; image(I); axis ij; hold on;
showboxes(I,  bestBBox);
saveas(gcf,'q22_test1.jpg')
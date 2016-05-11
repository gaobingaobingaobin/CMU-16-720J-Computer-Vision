% Created by 15213796 on 2015-10-21.

% Q3.3.1

imageDir = '../../data/voc2007';
addpath(genpath('../utils'));
addpath(genpath('../lib/esvm'));
addpath(genpath('../external'));
load('../../data/bus_esvm.mat');
load('../../data/bus_data.mat');

modelsize = length(models);
filterBank = createFilterBank();
alpha = 1000;
total_response = zeros(modelsize, length(filterBank)*3*alpha);
resizedimage = cell(1, modelsize);
response =  cell(1, modelsize);
sampledresponse =  cell(1, modelsize);


for i = 1:modelsize
    image = imread(fullfile(imageDir, models{i}.I));
    boundingbox =  models{i}.gt_box;
    boximage = image(boundingbox(2):boundingbox(4),boundingbox(1):boundingbox(3),:);
    resizedimage{i} = imresize(boximage, [100, 100]);
    response{i} = extractFilterResponses(resizedimage{i}, filterBank);
    pixels = randperm(alpha);
    sampledresponse{i}= response{i}(pixels, :);
    total_response(i, :) = reshape(sampledresponse{i}', 1, length(filterBank)*3*alpha);
end

K = 35;
[clusterindex_35, dictionary_35, ~, distance_35] = kmeans(total_response, K, 'EmptyAction', 'drop');
[~, detectorindex_35] = min(distance_35);
averageimage_35 = cell(1,K);

for i = 1: K
    array = find(clusterindex_35==i);
    totalimage = zeros(100,100,3);
    for j = 1 :size(array, 1)
        totalimage = totalimage + im2double(resizedimage{array(j)});
    end
    averageimage_35{i} = totalimage./size(array, 1);
end
imdisp(averageimage_35);
saveas(gcf,'average_image_35_sampled.jpg');

new_model_35 = models(detectorindex_35);
params = esvm_get_default_params();

L = length(gtImages);
new_boundingBoxes_35 = cell(1,L);
for i = 1:L
    fprintf('Calculating the bounding boxes of the image %s\n', gtImages{i});
    image = imread(fullfile(imageDir, gtImages{i}));
    new_boundingBoxes_35{i} = esvm_detect(image, new_model_35, params);
end

[~,~,ap_35] = evalAP(gtBoxes,new_boundingBoxes_35,0.5);





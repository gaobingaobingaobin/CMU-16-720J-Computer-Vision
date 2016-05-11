% Created by 15213796 on 2015-10-16.

function [boundingBoxes] = batchDetectImageESVM(imageNames, models, params)

numCores=2;
imageDir = '../../data/voc2007';

try
    fprintf('Closing any pools...\n');
    parpool close; 
catch ME
    disp(ME.message);
end

fprintf('Will process %d files in parallel to test the systems ...\n',length(imageNames));
fprintf('Starting a pool of workers with %d cores\n', numCores);
parpool('local',numCores);

L = length(imageNames);
boundingBoxes = cell(1,L);

parfor i=1:L
fprintf('Calculating the bounding boxes of the image %s\n', imageNames{i});
image = imread(fullfile(imageDir, imageNames{i}));
boundingBoxes{i} = esvm_detect(image, models, params);
end


fprintf('Closing the pool\n');
parpool close



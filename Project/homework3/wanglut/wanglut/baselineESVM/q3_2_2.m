% Created by 15213796 on 2015-10-18.

% Q3.2.2

addpath(genpath('../utils'));
addpath(genpath('../lib/esvm'));
addpath(genpath('../external'));
load('../../data/bus_esvm.mat');
load('../../data/bus_data.mat');
params = esvm_get_default_params();

detect_levels_per_octave = [3, 5, 10];
ap = zeros(1, 3);
boundingBoxes = cell(1, 3);

for i = 1:3
params.detect_levels_per_octave = detect_levels_per_octave(i);
boundingBoxes{i} = batchDetectImageESVM(gtImages, models, params);
[~,~,ap(i)] = evalAP(gtBoxes,boundingBoxes{i},0.5);
end
% plot(detect_levels_per_octave, ap);
% xlim([3 10]);
% ylim([0.2 0.4]) ;
% xlabel('lpo');
% ylabel('AP');
% saveas(gcf,'q32_result.jpg')


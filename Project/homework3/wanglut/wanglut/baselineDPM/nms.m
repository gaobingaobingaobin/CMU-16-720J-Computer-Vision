% Created by 15213796 on 2015-10-18.

function [refinedBBoxes] = nms(bboxes, bandwidth,K)

data = bboxes;
sizey = size(data, 2);
data(:, sizey) = data(:, sizey)+1;
stopThresh = 0.01*bandwidth;
[CCenters,CMemberships] = MeanShift(data,bandwidth,stopThresh);

 numOfClusters = size(CCenters, 1);

clusterWeight = hist(CMemberships,  numOfClusters)
[~, index] = sort(clusterWeight, 'descend');

if K >= numOfClusters
    refinedBBoxes = CCenters;
else
    refinedBBoxes = CCenters(index(1:K), :);
end

end








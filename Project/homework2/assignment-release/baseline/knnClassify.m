function [predictedLabel] = knnClassify(wordHist,trainHistograms,trainImageLabels,k)
%%%YOUR CODE HERE

distances = distanceToSet(wordHist, trainHistograms);
[~, pos] = sort(distances, 'descend');
index = trainImageLabels(pos(1:k));
%predictedLabel = classnames{mode(index)};
%index2 = unique(index);

predictedLabel = mode(index);

end

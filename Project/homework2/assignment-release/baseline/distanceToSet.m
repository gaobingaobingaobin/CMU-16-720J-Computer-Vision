function [histInter] = distanceToSet(wordHist, histograms)
%%%YOUR CODE HERE


histInter = sum(bsxfun(@min, wordHist, histograms));

end

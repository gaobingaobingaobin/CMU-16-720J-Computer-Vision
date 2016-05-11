function [h] = getImageFeatures(wordMap,dictionarySize)

wordMap_1 = wordMap(:);
h = hist(wordMap_1, dictionarySize);
h = h./size(wordMap_1, 1);
h = h';

%bar(h);
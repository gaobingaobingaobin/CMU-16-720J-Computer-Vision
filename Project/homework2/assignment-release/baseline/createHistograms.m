function outputHistograms = createHistograms(dictionarySize,imagePaths,wordMapDir)
%code to compute histograms of all images from the visual words
%imagePaths: a cell array containing paths of the images
%wordMapDir: directory name which contains all the wordmaps

%outputHistograms = []; %create a NumImage x histogram matrix of histograms.
                      %this variable will store all the histograms of training images

l = length(imagePaths);
outputHistograms = zeros(dictionarySize*(4^3-1)/3, l);
layerNum = 3;
for i = 1 : l
	wordMapFileName = fullfile(wordMapDir,strrep(imagePaths{i},'.jpg','.mat'));
    wordMap = load(wordMapFileName);
    wordMap = wordMap.wordMap;
    outputHistograms(:, i) = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
end
                      
                      

end

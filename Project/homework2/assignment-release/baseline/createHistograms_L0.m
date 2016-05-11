function outputHistograms_L0 = createHistograms_L0(dictionarySize,imagePaths,wordMapDir)


l = length(imagePaths);
outputHistograms_L0 = zeros(dictionarySize, l);
for i = 1 : l
	wordMapFileName = fullfile(wordMapDir,strrep(imagePaths{i},'.jpg','.mat'));
    wordMap = load(wordMapFileName);
    wordMap = wordMap.wordMap;
    outputHistograms_L0(:, i) = getImageFeatures(wordMap, dictionarySize);
end
                      
                      

end
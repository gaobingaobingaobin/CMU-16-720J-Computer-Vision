%Loading the dictionary, filters and training data
numCores=12;
imageDir = '../images'; %where all images are located
targetDir = '../wordmap';%where we will store visual word outputs 
layerNum = 3;
KNN = 20;
dictionarySize = size(dictionary, 1);
load('traintest.mat');
load('trainOutput.mat');

try
    fprintf('Closing any pools...\n');
    matlabpool close; 
catch ME
    disp(ME.message);
end

fprintf('Will process %d files in parallel to test the systems ...\n',length(testImagePaths));
fprintf('Starting a pool of workers with %d cores\n', numCores);
matlabpool('local',numCores);

testDir = '../testimage_wordmap';
for i = 1:length(classnames)
    if ~exist(fullfile(testDir,classnames{i}),'dir')
        mkdir(fullfile(testDir,classnames{i}));
    end
end


l = length(testImagePaths);
testM = zeros(l, 1);
predictM = zeros(l, 1);
wordRepresentation = cell(l,1);
accuracy = zeros(1, KNN);
C = cell(1, KNN);


parfor i=1:l
fprintf('Converting the test images to visual words %s\n', testImagePaths{i});
image = imread(fullfile(imageDir, testImagePaths{i}));
wordMap = getVisualWords(image, filterBank, dictionary);
wordRepresentation{i} = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
end
    
fprintf('Dumping the files\n');
for i=1:l
wordMap = wordRepresentation{i};
save(fullfile(testDir, [strrep(testImagePaths{i},'.jpg','.mat')]),'wordMap');
end

for knn = 1:KNN
    parfor i=1:l
    predictedLabel = knnClassify(wordRepresentation{i},trainHistograms,trainImageLabels,knn)
    testM(i) = testImageLabels(i);
    predictM(i) = predictedLabel;
    end
    [c,~]=confusionmat(testM,predictM); 
    accuracy(knn) = trace(c)/sum(c(:));
    C{knn} =  c;
    disp(c);
    fprintf('when k is%d, the accuracy is %f\n', knn, accuracy(knn));
end
%save('evaluateRecognition.mat','C','accuracy','wordRepresentation');


fprintf('Closing the pool\n');
matlabpool close

% plot(accuracy);
% xlim([1 20]);
% ylim([0.5 0.7]) ;
% xlabel('K');
% ylabel('Accuracy');
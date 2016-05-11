
load('traintest.mat');
imageDir = '../images'; %where all images are located
targetDir = '../wordmap';%where we will store visual word outputs 

l = length(trainImagePaths);
dictionarySize = size(dictionary, 1);
% total_patch_r = cell(dictionarySize, 1);
% total_patch_g = cell(dictionarySize, 1);
% total_patch_b = cell(dictionarySize, 1);
total_patch = cell(dictionarySize, 1);
for i = 1:dictionarySize
    total_patch{i} = zeros(9,9,3);
end
% counter_r = zeros(dictionarySize, 1);
% counter_g = zeros(dictionarySize, 1);
% counter_b = zeros(dictionarySize, 1);
counter = zeros(dictionarySize, 1);

    for i = 1 : l
        wordMapFileName = fullfile(targetDir,strrep(trainImagePaths{i},'.jpg','.mat'));
        imageFileName = fullfile(imageDir,trainImagePaths{i});
        image = imread(imageFileName);
        wordMap = load(wordMapFileName);
        wordMap = wordMap.wordMap; 
        numx = floor(size(wordMap, 1)/9);
        x = numx * 9;
        numy = floor(size(wordMap, 2)/9);
        y = numy * 9;
        wordMap = wordMap(1:x, 1:y);
        image = image(1:x, 1:y, :);
        mx = 9*ones(1, numx);
        my = 9*ones(1, numy);
        wordMap_patch = mat2cell(wordMap,mx, my);
%         image_patch_r = cell(image(:,:,1), mx, my);
%         image_patch_g = cell(image(:,:,2), mx, my);
%         image_patch_b = cell(image(:,:,3), mx, my);
        image_patch = mat2cell(image, mx, my,[1 1 1]);
        
        for j = 1:numx
            for k = 1:numy
            patch = wordMap_patch{j, k};
            index = patch(41);
%             I_r = image_patch_r{j};
%             I_g = image_patch_g{j};
%             I_b = image_patch_b{j};
            I = im2double(cell2mat(image_patch(j, k, :)));
            %I = mat2cell(I, 9,9,3);
%             total_patch_r{index, 1} = total_patch_r{index, 1}+I_r;
%             counter_r(index, 1) = counter_r(index, 1)+1;
%             total_patch_g{index, 1} = total_patch_g{index, 1}+I_g;
%             counter_g(index, 1) = counter_g(index, 1)+1;
%             total_patch_b{index, 1} = total_patch_b{index, 1}+I_b;
%             counter_b(index, 1) = counter_b(index, 1)+1;
            total_patch{index, 1} = total_patch{index, 1}+ I;
            counter(index, 1) = counter(index, 1)+1;
            end
        end
   end
        
   for i = 1:dictionarySize
%      total_patch_r(i, 1) = total_patch_r(i, 1) ./ counter_r(i, 1);
%      total_patch_g(i, 1) = total_patch_g(i, 1) ./ counter_g(i, 1);
%      total_patch_b(i, 1) = total_patch_b(i, 1) ./ counter_b(i, 1);   
        total_patch(i, 1) = mat2cell((cell2mat(total_patch(i, 1)) / counter(i, 1)), 9,9,3);
   end
   
   save('dictionary_patch.mat','total_patch');
   
   
   %imdisp(total_patch)
   % export_fig(gcf ,'myfig','width',6 ,'format','jpeg');
   
    
        

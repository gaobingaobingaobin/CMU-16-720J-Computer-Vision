function F = genFeatureMatrix(perturbedConfigurations, n)

Files = dir(fullfile('data/pooh/training','*.jpg'));

%numOfFrame = size(annotations, 1);
numOfFrame = length(perturbedConfigurations);
F = zeros(numOfFrame*n, 640);

for i = 1:numOfFrame
     %singleFrameAnnotation = reshape(annotations(i, 2:11), [2, 5])';
     %perturbedConfigurations = genPerturbedConfigurations(singleFrameAnnotation, meanShape, n, scalesToPerturb);
     I = imread(strcat('data/pooh/training/',Files(i).name));
     total_sift = siftwrapper(I, perturbedConfigurations{i});
     %norm1 = norm(total_sift);
     %total_sift = total_sift ./ repmat(norm1, [128, 1]);
     
     for j = 1:n
         sift = total_sift(:, (j-1)*5+1:j*5);
         for m = 1:5
            norm_sift = norm(sift(:, m));
            sift = sift./norm_sift;
         end  
         F((i-1)*n+j, :) = sift(:)';
     end
end
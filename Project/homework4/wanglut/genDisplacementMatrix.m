function D = genDisplacementMatrix(perturbedConfigurations,annotations, n)

numOfFrame = length(perturbedConfigurations);
D = zeros(numOfFrame*n, 10);

for i = 1:numOfFrame
    perturbedPositon = reshape(perturbedConfigurations{i}(1:2, :), [1, n*10]);
    D((i-1)*n+1:i*n,:) = (reshape(repmat(annotations(i, 2:11), 1, n)-perturbedPositon,[10, n]))';
end
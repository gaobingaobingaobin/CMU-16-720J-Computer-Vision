function [models, loss] = SDMtrain(mean_shape, annotations)

n = 100;
scalesToPerturb = [0.8, 1.0, 1.2];

numOfFrame = size(annotations, 1);
perturbedConfigurations = cell(numOfFrame, 1);

for i = 1:numOfFrame
     singleFrameAnnotation = reshape(annotations(i, 2:11), [2, 5])';
     perturbedConfigurations{i} = genPerturbedConfigurations(singleFrameAnnotation, mean_shape, n, scalesToPerturb);
end

D = genDisplacementMatrix(perturbedConfigurations,annotations, n);
F = genFeatureMatrix(perturbedConfigurations, n);

models = cell(10, 1);
loss = zeros(1, 10);

for i = 1:10
    [new_perturbedConfigurations, models{i}] = learnMappingAndUpdateConfiguration(F, D, perturbedConfigurations, n, annotations);
    D = genDisplacementMatrix(new_perturbedConfigurations, annotations, n);
    loss(i) = norm(D);
    F = genFeatureMatrix(new_perturbedConfigurations, n);
    perturbedConfigurations = new_perturbedConfigurations;
end



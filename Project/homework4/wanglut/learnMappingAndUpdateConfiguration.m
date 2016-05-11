function [new_perturbedConfigurations, models] =learnMappingAndUpdateConfiguration(F, D, perturbedConfigurations, n, annotations)

    models = learnLS(F, D);
    new_displacement = F*models;

    numOfFrame = length(perturbedConfigurations);
    
    for i = 1:numOfFrame
        perturbedPositon = reshape(perturbedConfigurations{i}(1:2, :), [1, n*10]);
        new_position = new_displacement((i-1)*n+1:i*n, :) + reshape(perturbedPositon, 10, n)';
       temp = reshape(new_position(1, :), [2, 5]);
       singleFrameAnnotation = reshape(annotations(i, 2:11), [2, 5])';
       scale = findscale(singleFrameAnnotation, temp');
       new_perturbedConfigurations{i}(3, 1:5) = [7 4 4 10 10]/scale;
       for j = 2:n
           scale = findscale(singleFrameAnnotation, reshape(new_position(j, :), [2, 5])');
           temp = [temp,reshape(new_position(j, :), [2, 5])];
           new_perturbedConfigurations{i}(3, 5*(j-1)+1:5*j) = [7 4 4 10 10]/scale;
       end
       new_perturbedConfigurations{i}(1:2, :) = temp;
       new_perturbedConfigurations{i}(4, :) = zeros(1, n*5);
    end
    
end
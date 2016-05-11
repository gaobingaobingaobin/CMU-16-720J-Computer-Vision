function perturbedConfigurations = genPerturbedConfigurations(singleFrameAnnotation, meanShape, n, scalesToPerturb)

scale = findscale(singleFrameAnnotation, meanShape);
meanShape = meanShape/scale;
[center_shift] = mean(singleFrameAnnotation) -mean(meanShape);
meanShape(:,1) = meanShape(:,1)+ center_shift(1);
meanShape(:,2) = meanShape(:,2)+ center_shift(2);

perturbedConfigurations = zeros(4, 5*n);
[center_pos] = mean(meanShape);
for i = 1:n
    scale_to_pertubred = scalesToPerturb(ceil(size(scalesToPerturb, 2)*rand));
    scale_meanShape = scale_to_pertubred*meanShape;
    scale_center = mean(scale_meanShape);
    certer_shiftx = center_pos(1) - scale_center(1);
    certer_shifty = center_pos(2) - scale_center(2);
    
    scale_meanShape(:,1) = scale_meanShape(:,1)+ certer_shiftx;
    scale_meanShape(:,2) = scale_meanShape(:,2)+ certer_shifty;

    x_move = (rand*2-1)*5;
    y_move = (rand*2-1)*5;
    
    for j = 1:5
        perturbedConfigurations(1, (i-1)*5+j) = scale_meanShape(j, 1)+ x_move;
        perturbedConfigurations(2, (i-1)*5+j) = scale_meanShape(j, 2)+ y_move;
    end
    
    perturbedConfigurations(3, (i-1)*5+1:i*5) = [7 4 4 10 10]/scale*scale_to_pertubred;
end

end
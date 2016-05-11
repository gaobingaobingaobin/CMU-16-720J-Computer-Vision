function SDMtrack(models, mean_shape, start_location, start_frame, outvidfile)

	vidout = VideoWriter(outvidfile);
	vidout.FrameRate = 20;
	open(vidout);

	new_Configurations= zeros(4, 5);
    numOfModel = length(models);
	for iFrm = start_frame:3000
        
	   I = imread(sprintf('data/pooh/testing/image-%04d.jpg', iFrm));
       scale = findscale(start_location, mean_shape);
       mean_shape = mean_shape/scale;
       center_shift = mean(start_location-mean_shape);
       mean_shape(:,1) = mean_shape(:,1)+ center_shift(1);
       mean_shape(:,2) = mean_shape(:,2)+ center_shift(2);

       begin_shape =  mean_shape;
       current_shape = begin_shape;   
       new_Configurations(1:2, :) = begin_shape';
       new_Configurations(3, :) = [7 4 4 10 10]/scale;
        
        for i = 1:numOfModel
            temp_sift = siftwrapper(I, new_Configurations);
               for m = 1:5
                    sift_norm = norm(temp_sift(:, m));
                    temp_sift(:, m) = temp_sift(:, m)/sift_norm;
               end
               sift = temp_sift(:)';
               new_displacement = sift*models{i};

              current_shape = current_shape + reshape(new_displacement, [2, 5])';
              scale = findscale(start_location, current_shape);
              new_Configurations(1:2, :) = current_shape';
              new_Configurations(3, :) = [7 4 4 10 10]/scale;
        end
        
		figure(1);
		if ~exist('hh','var'), hh = imshow(I); hold on; 
		else set(hh,'cdata',I);
		end
		if ~exist('hPtBeg','var'), hPtBeg = plot(begin_shape(:,1), begin_shape(:,2), 'g+', 'MarkerSize', 15, 'LineWidth', 3);
		else set(hPtBeg,'xdata',begin_shape(:,1),'ydata',begin_shape(:,2));
		end
		if ~exist('hPtcurrent_shape','var'), hPtcurrent_shape = plot(current_shape(:,1), current_shape(:,2), 'r+', 'MarkerSize', 25, 'LineWidth', 5);
		else set(hPtcurrent_shape,'xdata',current_shape(:,1),'ydata',current_shape(:,2));
		end
		title(['frame ',num2str(iFrm)]);
		if ~exist('hFrmNum', 'var'), hFrmNum = text(30, 30, ['Frame: ',num2str(iFrm)], 'fontsize', 40, 'color', 'r');
		else set(hFrmNum, 'string', ['Frame: ',num2str(iFrm)]);
		end

		frm = getframe;
		writeVideo(vidout, imresize(frm.cdata, 0.5));
        
        start_location = current_shape;
	end

	close(vidout);
end

% Created by wanglut (NOV-5-2015)

addpaths; 

load('data/pooh/rects_frm992.mat');
Files = dir(fullfile('data/pooh/testing','*.jpg'));
LengthFiles = length(Files);

for i = 1:LengthFiles
    fprintf('loading the image %s\n', Files(i).name);
    sequence(:,:,:,i) = imread(strcat('data/pooh/testing/',Files(i).name)); 
end

vidname = 'pooh_lk.avi';
vidout  = VideoWriter(vidname);
vidout.FrameRate = 10;
open(vidout);

rect = {rect_lear, rect_leye, rect_nose, rect_rear, rect_reye};
drawFrmPooh(sequence, rect,1); text(80,100,'Ready?','color','r','fontsize',30); pause(1);
drawFrmPooh(sequence, rect,1); text(80,160,'GO!','color','g','fontsize',80); pause(.5);

for iFrm = 2:LengthFiles
	It    = sequence(:,:,:,iFrm-1);   % get previous frame
	It1   = sequence(:,:,:,iFrm);     % get current frame
	for j = 1:5
         [u,v] = LucasKanade(It,It1,rect{j}); % compute the displacement using LK
         rect{j}  = rect{j} + [u,v,u,v];         % move the rectangle
    end
	hf  = drawFrmPooh(sequence, rect, iFrm); % draw frame
    frm = getframe;
	writeVideo(vidout, imresize(frm.cdata, 0.5));
end

close(vidout);
close(1);
fprintf('Video saved to %s\n', vidname);



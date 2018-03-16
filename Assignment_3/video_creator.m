outputVideo = VideoWriter(fullfile('vid/','toy_vid_out.avi'));
%outputVideo.FrameRate = shuttleVideo.FrameRate;
open(outputVideo);
for i = 1:103
   img = imread(strcat('vid/toy/',num2str(i),'.png'));
   img=imresize(img,[1033,1431]);
   writeVideo(outputVideo,img)
end
close(outputVideo)
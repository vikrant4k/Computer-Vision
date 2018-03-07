outputVideo = VideoWriter(fullfile('vid/','toy_vid_out.avi'));
%outputVideo.FrameRate = shuttleVideo.FrameRate;
open(outputVideo);
for i = 1:103
   img = imread(strcat('vid/',num2str(i),'.png'));
   writeVideo(outputVideo,img)
end
1
close(outputVideo)
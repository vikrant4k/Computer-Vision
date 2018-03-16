function make_video(images_folder, output_folder, file_name)

files = dir(strcat(images_folder,'/'));

outputVideo = VideoWriter(fullfile(output_folder,file_name));

%outputVideo.FrameRate = shuttleVideo.FrameRate;
open(outputVideo);
j = 0
for i = 1:length(files)
%for i = 1:103
    j = j + 1
   file_name = files(j).name
   if contains(file_name, '.png')
       img = imread(strcat(images_folder,'/',file_name));
       img=imresize(img,[1033,1431]);
       writeVideo(outputVideo,img)
   end
end
close(outputVideo)
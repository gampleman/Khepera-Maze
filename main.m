% get image of the world
I0 = take_snap();
%unix('mplayer tv:// -tv driver=v4l:width=640:height=480:device=/dev/video0 -frames 5 -vo jpeg');
%I0 = imread('00000003.jpg');

% use the jacobean transform
I1 = jacobean(I0, 400, 260, getcorners(~im2bw(I0), 0.5));

%[target, start] = getendpoints(I1);
%if((target(2) - start(2))^2 + (target(1) - start(1))^2 > 190^2)
%  I1 = jacobean(I0, 400, 260, getcorners(~im2bw(I0), 0.5));
%  [target, start] = getendpoints(I1);
%end



robot = getrobot(I1);
old_robot = robot;
% find the target point
target = getendpoints(I1);
% plan path
I2 = imclose(~im2bw(I1, 0.7), strel('disk', 10));
[w h] = size(I2);
 
while scanline(I2, robot(2), 20)
  drivebot(20);
  visualturn(old_robot, robot, 1);
  
  I0 = take_snap();
  

  % use the jacobean transform
  I1 = jacobean(I0, 400, 260, getcorners(~im2bw(I0), 0.5));
  
  robot = getrobot(I1);
  old_robot = robot;
  %pause(0.1);
end

stopbot;
drivebot(-20, 20, 3.8)


drivebot(20, 40);
stopbot;

%while true
  % get image of the world
  %I0 = take_snap();
  unix('mplayer tv:// -tv driver=v4l:width=640:height=480:device=/dev/video0 -frames 5 -vo jpeg');
  I0 = imread('00000003.jpg');
  figure(1)
  imshow(I0)
  % use the jacobean transform
  I1 = jacobean(I0, 260, 400, getcorners(~im2bw(I0), 0.5));
  
  %[target, start] = getendpoints(I1);
  %if((target(2) - start(2))^2 + (target(1) - start(1))^2 > 190^2)
  %  I1 = jacobean(I0, 400, 260, getcorners(~im2bw(I0), 0.5));
  %  [target, start] = getendpoints(I1);
  %end
  % get green thing -> robot
  green_thresh = 200/255;
  red_thresh = 100/255;
[xs, ys] = find(I1(:, :, 2) > green_thresh & I1(:, :, 1) < red_thresh)
  robot = [mean(xs), mean(ys)]
    
    figure(2)
    imshow(I1)
    %hold on
    %text(robot(1), robot(2), 'Robot');
    %plot(robot(2), robot(1), 'ko');
   
  % find the target point
  target = getendpoints(I1);
  % plan path
  
  % take next segment of path and send servoing signal
  
  %sleep(1)
%end

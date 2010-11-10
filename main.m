%while true
  % get image of the world
  IM1 = imread('world2010.png', 'png');
  
  % use the jacobean transform
  IM2 = jacobean(IM1, 260,400, getroundobjects(~im2bw(IM1, graythresh(IM1)), 0.5));
  
  % find the robot.
  red_thresh = 20/255;
  green_thresh = 220/255;
  blue_thresh = 98/255;
  [a,b] = find(IM2(:,:,1) < red_thresh & IM2(:,:,2) > green_thresh & IM2(:,:,3) < blue_thresh);
  IM3 = zeros(size(IM2));
  IM3(a, b, :) = 1;
  imshow(IM3)
  robot = [mean(b), mean(a)]
  hold on
  plot(robot(1), robot(2), 'ro')
  
  %   figure(1)
  %   imshow(IM1)
  %   figure(2)
  %   imshow(IM2)
  %   IM3 = zeros(size(IM2));
  %   IM3(xs, ys, :) = 1;
  %   figure(3)
  %   imshow(IM3)
  % find the target point
  
  % plan path
  
  % take next segment of path and send servoing signal
  
  %sleep(1)
%end

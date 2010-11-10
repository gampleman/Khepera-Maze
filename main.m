%while true
  % get image of the world
  I0 = take_snap();
  % use the jacobean transform
  I1 = jacobean(I0, 400, 260, getroundobjects(~im2bw(I0), 0.5));
  % get green thing -> robot
  green_thresh = 200/255;
  red_thresh = 100/255;
[xs, ys] = find(I1(:, :, 2) > green_thresh & I1(:, :, 1) < red_thresh)
  robot = [mean(xs), mean(ys)]
    figure(1)
    imshow(I0)
    figure(2)
    imshow(I1)
    hold on
    text(robot(1), robot(2), 'Robot');
    plot(robot(2), robot(1), 'ko');
    I2 = zeros(size(I1));
    I2(xs, ys, :) = 1;
    figure(3)
    imshow(I2)
  % find the target point
  
  % plan path
  
  % take next segment of path and send servoing signal
  
  %sleep(1)
%end

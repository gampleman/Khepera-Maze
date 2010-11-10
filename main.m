while true
  % get image of the world
  I = take_snap();
  % use the jacobean transform
  I = jacobean(I, 260, 400, getroundobjects(~im2bw(I), 0.5));
  % get green thing -> robot
  green_thresh = 200;
  red_thresh = 40;
  [xs, ys] = find(I(:, :, 2) > green_thresh & I(:, :, 1) > red_thresh);
  robot = [mean(xs), mean(ys)];
  % find the target point
  
  % plan path
  
  % take next segment of path and send servoing signal
  
  sleep(1)
end
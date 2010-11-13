% setup
robot = [0 0];
updaterobot;
old_robot = robot;
decay = 1;
robot_size = 20;
% find the target point
target = getendpoints(I1);
% create maze map
I2 = imclose(~im2bw(I1, 0.7), strel('disk', 10));

% drive horizontal till opening
dimension = 2;
while scanline(I2, robot(dimension), robot_size, dimension)
  updaterobot;
  visualturn(old_robot, robot, dimension);
end

% drive vertical till opening
dimension = 1;
while scanline(I2, robot(dimension), robot_size, dimension)
  updaterobot;
  visualturn(old_robot, robot, dimension);
end

% drive horizontal till close enough to target point
dimension = 2;
while ((target(2) - robot(2))^2 + (target(1) - robot(1))^2 > robot_size^2)
  updaterobot;
  visualturn(old_robot, robot, dimension);
end

% we're done.
stopbot;



%drivebot(-20, 20, 3.8)
%drivebot(20, 40);
%stopbot;
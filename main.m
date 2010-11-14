% setup
%

global environment;
global decay;
%environment = 'webots';

if strcmp(environment, 'real world')
 I0 = take_pic();
 pause(0.1);
 jac_dimensions = [260, 400];
 % use the jacobean transform
 I4 = imfill(imclose(~im2bw(I0, graythresh(I0)), strel('disk',1)), 'holes');
 corners = getcorners(I4, 0.8);
 I3 = jacobean(I0, 260, 400, corners);

 [target, start] = getendpoints(I3);
 if true%((target(2) - start(2))^2 + (target(1) - start(1))^2 > 190^2)
   I3 = jacobean(I0, 400, 260, getcorners(imfill(~im2bw(I0, graythresh(I0)), 'holes'), 0.8));
   [target, start] = getendpoints(I3);
   jac_dimensions = [400 260];
 end
 I2 = imclose(~im2bw(I3, graythresh(I3)), strel('disk', 10));
  input('Place da robot, man!')
else
  jac_dimensions = [400, 260];
  updaterobot;
  I3 = [];
  I2 = imclose(~im2bw(I1, 0.7), strel('disk', 10));
end
robot = [0 0];
updaterobot;
old_robot = robot;
old_robot(1) = old_robot(1) - 10;
decay = 1;
robot_size = 10;
% find the target point
target = getendpoints(I1);
% create maze map
%I2 = imclose(~im2bw(I1, 0.7), strel('disk', 10));
%I2 = imclose(~im2bw(I1, graythresh(I1)), strel('disk', 10));
%imshow(I2);
% drive horizontal till opening
robot
dimension = 2
decay = 2;
visualturn(old_robot, robot, dimension, 2);
while scanline(I2, robot(dimension), robot_size, dimension)
  updaterobot;
  visualturn(old_robot, robot, dimension, 2);
end


% drive vertical till opening
dimension = 1
decay = 2;
%while scanline(I2, robot(dimension), robot_size, dimension) && t < 30
while ~(robot(1) > target(1) - robot_size && robot(1) < target(1) + robot_size)
  updaterobot;
  visualturn(old_robot, robot, dimension, 1);
end

% drive horizontal till close enough to target point
dimension = 2
decay = 2;
while ((target(2) - robot(2))^2 + (target(1) - robot(1))^2 > robot_size^2)
  updaterobot;
  visualturn(old_robot, robot, dimension, 1);
end

% we're done.
stopbot;



%drivebot(-20, 20, 3.8)
%drivebot(20, 40);
%stopbot;

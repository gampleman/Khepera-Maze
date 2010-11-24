% Setup some global state
global environment;
global previous_error;
global l_integral;
global r_integral;
robot = [0 0];
previous_error = 0;
l_integral = 0;
r_integral = 0;

% Stop the robot if it's running
stopbot;

% Prepare vars depending on environment
if strcmp(environment, 'real world')
  [robot_size, transformdims, corners, I0, I2, I3] = realworld();
else
  [robot_size, transformdims, corners, I0, I2] = webots();
  I3 = [];
end

updaterobot;
% Get the maze to navigate in


old_robot = robot;
old_robot(1) = old_robot(1) - 10;

% find the target point
target = getendpoints(I1);


freespace = robot(2);
dir = sign(size(I2, 1)/2 - robot(2));
while scanline(I2, freespace, 10)
    freespace = freespace + dir;
end
%freespace = freespace - dir;
drivebot(1);
dest = [robot(1), freespace]

figure(2)
imshow(I2)
drawnow
hold on;
plot(dest(2), dest(1), 'ro');  

drivetopoint


% drive vertical till opening
dest = [target(1) freespace]
plot(dest(2), dest(1), 'ro');  
drivetopoint


dest = target'

plot(target(2), target(1), 'ro');  

% drive horizontal till close enough to target point

drivetopoint


% we're done.
stopbot;

function rc()


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
environment
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


f = figure(2);
imshow(I2)
drawnow
hold on;
plot(dest(2), dest(1), 'ro');  
plot(freespace, target(1) + shift, 'ro');
plot(target(2), target(1), 'ro');

set(f, 'ButtonDownFcn', @click);
    function click(varargin)
        pt = get(f, 'CurrentPoint') 
        drivetopoint
        stopbot
    end




end
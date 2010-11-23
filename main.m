% setup
%

global environment;
global previous_error;
global l_integral;
global r_integral;
%environment = 'webots';

robot = [0 0];
previous_error = 0;
l_integral = 0;
r_integral = 0;

stopbot;
if strcmp(environment, 'real world')
robot_size = 15;
 I0 = take_pic();
 pause(0.1);
 %jac_dimensions = [260, 400];
 % use the jacobean transform
 I4 = imfill(imclose(~im2bw(I0, graythresh(I0)), strel('disk',1)), 'holes');
 corners = getcorners(imfill(~im2bw(I0, graythresh(I0)), 'holes'), 0.8);%getcorners(I4, 0.8);
 %I3 = jacobean(I0, 260, 400, corners);

 %[target, start] = getendpoints(I3);
 %if true%((target(2) - start(2))^2 + (target(1) - start(1))^2 > 190^2)
   I3 = jacobean(I0, 400, 260, corners);
   [target, start] = getendpoints(I3);
   jac_dimensions = [400 260];
 %end
  I2 = imclose(~im2bw(I3, graythresh(I3)), strel('disk', 10));
  input('Place da robot, man!')
else
robot_size = 10;
  jac_dimensions = [400, 260];
  updaterobot;
  I3 = [];
  I2 = imclose(~im2bw(I1, 0.7), strel('disk', 10));
end

updaterobot;
old_robot = robot;
old_robot(1) = old_robot(1) - 10;

% find the target point
target = getendpoints(I1)
% create maze map
%I2 = imclose(~im2bw(I1, 0.7), strel('disk', 10));
%I2 = imclose(~im2bw(I1, graythresh(I1)), strel('disk', 10));
%imshow(I2);
% drive horizontal till openin
drivebot(1);
freespace = robot(2);
dir = sign(size(I2, 1)/2 - robot(2));
while scanline(I2, freespace, 10, 2)
    freespace = freespace + dir;
end
freespace = freespace - dir;

dest = [robot(1) freespace];


imshow(I2); hold on;
plot(dest(2), dest(1), 'ro');  

drivetopoint


% drive vertical till opening
dest = [target(1) freespace];
plot(dest(2), dest(1), 'ro');  
drivetopoint


dest = target';

plot(target(2), target(1), 'ro');  

% drive horizontal till close enough to target point

drivetopoint


% we're done.
stopbot;

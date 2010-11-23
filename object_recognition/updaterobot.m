%unix('rm /tmp/snapshot.ppm');
I0 = take_pic();
%pause(0.1);
% use the jacobean transform


I1 = jacobean(I0, jac_dimensions(1), jac_dimensions(2), corners);%getcorners(~im2bw(I0), 0.5));

old_robot = robot;
robot = getrobot(I1, I3);



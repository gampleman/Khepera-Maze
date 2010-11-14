%unix('rm /tmp/snapshot.ppm');
I0 = take_pic();
pause(0.1);
% use the jacobean transform
corners = getcorners(~im2bw(I0, graythresh(I0)), 0.8);

I1 = jacobean(I0, jac_dimensions(1), jac_dimensions(2), getcorners(~im2bw(I0, graythresh(I0)), 0.8));


old_robot = robot;
robot = getrobot(I1, I3);



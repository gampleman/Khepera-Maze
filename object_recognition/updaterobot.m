%unix('rm /tmp/snapshot.ppm');
I0 = take_pic();
%pause(0.1);
% use the jacobean transform


I1 = jacobean(I0, jac_dimensions(1), jac_dimensions(2), corners);%getcorners(~im2bw(I0), 0.5));
%if jac_dimensions(1) < jac_dimensions(2)
%    I1 = I1';
%end
    
old_robot = robot;
robot = getrobot(I1, I3);
%if jac_dimensions(1) < jac_dimensions(2)
%    jac_dimensions
%    robot = [robot(2) robot(1)];
%end


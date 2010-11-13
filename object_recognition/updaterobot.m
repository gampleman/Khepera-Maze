I0 = take_snap();
% use the jacobean transform
I1 = jacobean(I0, 400, 260, getcorners(~im2bw(I0), 0.5));


%[target, start] = getendpoints(I1);
%if((target(2) - start(2))^2 + (target(1) - start(1))^2 > 190^2)
%  I1 = jacobean(I0, 400, 260, getcorners(~im2bw(I0), 0.5));
%  [target, start] = getendpoints(I1);
%end

old_robot = robot;
robot = getrobot(I1);
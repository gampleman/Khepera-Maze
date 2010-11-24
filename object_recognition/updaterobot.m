tic;
I0 = take_pic();

%I1 = ptransform(I0, transformdims(1), transformdims(2), corners);
I1 = nicetransform(I0, transformdims, corners);

    
old_robot = robot;
robot = getrobot(I1, I3);


dt = toc;
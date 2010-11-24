function [robot_size, transformdims, corners, I0] = webots()
  robot_size = 10;
  transformdims = [260, 400];
  updaterobot;
  I3 = [];
  


  target = getendpoints(I1);
  start = robot;
  
  % here we check to see if we are transformed
  if ((target(2) - start(2))^2 + (target(1) - start(1))^2 > 190^2)
   transformdims = [400 260];
   I1 = ptransform(I0, transformdims(1), transformdims(2), corners);
  else
   I1 = imrotate(I1, 90);
  end
end %  function
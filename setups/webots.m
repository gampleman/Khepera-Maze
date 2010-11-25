function [robot_size, transformdims, corners, I0, I2] = webots()
  robot_size = 5;
  transformdims = [260, 400];
  I0 = take_pic();
  corners = getcorners(imfill(~im2bw(I0, graythresh(I0)), 'holes'), 0.8);
  robot = [0 0];
  I3 = [];
  updaterobot;
  target = getendpoints(I1);
  start = robot;
  
  % here we check to see if we are transformed
  if ((target(2) - start(2))^2 + (target(1) - start(1))^2 > 190^2)
   transformdims = [400 260];
   I1 = ptransform(I0, transformdims(1), transformdims(2), corners);
  end
  I2 = imclose(~im2bw(I1, 0.7), strel('disk', 10));
end %  function
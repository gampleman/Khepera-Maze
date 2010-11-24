function robot = getrobot(I, varargin)
%GETROBOT Return th robot location.
%
%   [ROBOT] = GETROBOT(I, varargin) In the webot environment the function 
%   expects one argument/Image and locate the robot by it's colour.
%   In real life environment the function expects two arguments/Images and
%   locate the robot by finiding the largest difference between the two.

global environment;

if length(varargin) > 1
  error('getrobot:TooManyInputs requires at most one input.');
else if strcmp(environment, 'webots')
  green_thresh = 200/255;
  red_thresh = 100/255;
  [xs, ys] = find(I(:, :, 2) > green_thresh & I(:, :, 1) < red_thresh);
else % environment == 'real life'
  l = getlargest(~im2bw(I, graythresh(I)) - ~im2bw(varargin{1}, graythresh(varargin{1})), 0);
  
  [xs, ys] = find(l == 1);
end

robot = [mean(xs), mean(ys)]

end %  function



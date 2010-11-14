function robot = getrobot(I, varargin)
%   GETROBOT   Short description
%     [ROBOT] = GETROBOT(I)
% 
%   Long description
%   
%   Created by Jakub Hampl on 2010-11-12.
global environment;
if strcmp(environment, 'webots')
green_thresh = 200/255;
red_thresh = 100/255;
[xs, ys] = find(I(:, :, 2) > green_thresh & I(:, :, 1) < red_thresh);
else
l = getlargest(~im2bw(I, graythresh(I)) - ~im2bw(varargin{1}, graythresh(varargin{1})), 0);
[xs, ys] = find(l == 1);
end
robot = [mean(xs), mean(ys)]



end %  function

function robot = getrobot(I)
%   GETROBOT   Short description
%     [ROBOT] = GETROBOT(I)
% 
%   Long description
%   
%   Created by Jakub Hampl on 2010-11-12.


green_thresh = 200/255;
red_thresh = 100/255;
[xs, ys] = find(I(:, :, 2) > green_thresh & I(:, :, 1) < red_thresh);
robot = [mean(xs), mean(ys)];

end %  function
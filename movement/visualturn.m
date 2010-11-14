function visualturn(old, new, dimension, direction)
%% See images/robot-control-diagram for explanation of this function
global decay;

a = old(dimension) - new(dimension);
c = sqrt((old(1) - new(1))^2 + (old(2) - new(2))^2);

other_dimension = 3 - dimension;
if direction == 1
  alpha = pi - acos(a / c);
  if old(other_dimension) < new(other_dimension)
    alpha = alpha * -1;
  end
else
  alpha = acos(a / c);
  if old(other_dimension) > new(other_dimension)
    alpha = alpha * -1;
  end
end
V = 10;
decay;

decay = decay * 0.9;

if abs(alpha) < 0.0873
  alpha = 0;
  %v = 20;
  decay = 2;
end


%vl = V * (1 + decay * alpha / (-0.5 * pi));
%vr = V * (1 + decay * alpha / (0.5 * pi));

vl = V * (1 + alpha / (-0.5 * pi));
vr = V * (1 + alpha / (0.5 * pi));

drivebot(vl, vr, 0.1);

end %  function

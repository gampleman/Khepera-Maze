function pid(old, new, dimension, direction)
%   PID   implements PID cotnrol for the robot
%      PID(old, new, dimension, direction)
% 
%   Long description
%   
%   Created by Jakub Hampl on 2010-11-16.


global previous_error, l_integral, r_integral, environment;

Kp = 1;
Kd = 0;
Ki = 0;


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

if strcmp(environment, 'webots')
  V = 30;
else
  V = 1.5;
end


dt = 0.1;

l_integral = l_integral + (-alpha*dt);
l_derivative = (-alpha - previous_error)/dt;
l_output = (Kp* -alpha) + (Ki*l_integral) + (Kd*l_derivative)


r_integral = r_integral + (alpha*dt);
r_derivative = (alpha - previous_error)/dt;
r_output = (Kp*alpha) + (Ki*r_integral) + (Kd*r_derivative)
previous_error = alpha;

vl = V * l_output;
vr = V * r_output;

drivebot(vl, vr, dt);


end %  function
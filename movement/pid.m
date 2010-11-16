function pid(old, new, dimension, direction)
%   PID   implements PID cotnrol for the robot
%      PID(old, new, dimension, direction)
% 
%   Long description
%   
%   Created by Jakub Hampl on 2010-11-16.


global previous_error
global l_integral;
global r_integral;
global environment;

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


dt = 0.2;

l_error = alpha / (-1 * pi);
l_integral = l_integral + (-l_error*dt);
l_derivative = (-l_error - previous_error / -pi)/dt;
l_output = (Kp* -l_error) + (Ki*l_integral) + (Kd*l_derivative)

r_error = alpha / ( pi);
r_integral = r_integral + (r_error*dt);
r_derivative = (r_error - previous_error/ pi)/dt;
r_output = (Kp*r_error) + (Ki*r_integral) + (Kd*r_derivative)

previous_error = alpha;

vl = V * l_output;
vr = V * r_output;

drivebot(vl, vr, 0.1);


end %  function
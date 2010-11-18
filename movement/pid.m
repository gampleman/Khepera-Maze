function pid(old, new, destination, dimension, direction)
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

Kp = 0.25;
Ki = 0.1;
Kd = 0.3;
%t = old - destination;
%d = sqrt(t .^ 2);
%n = [-t(2) t(1)];
%ac = new - old;
%b = ac .* n;
%b = abs(sum(ac .* n)) %sqrt(sum(b .^2))
%b = norm(cross(old - new,destination' - new)) / norm(old - new)
a = new - old;
b = destination - new;

%alpha = acos(a*b' / ((a*a')*(b*b')));
%a_d = alpha * 180 / pi
%costheta = dot(a,b)/(norm(a)*norm(b));
%alpha = atan2(a(1)*b(2)-a(1)*b(1),a(1)*b(1)+a(2)*b(2));
%alpha = atan2(a(1) - b(1), a(2) - b(2));

beta = atan2(a(1), a(2));
gamma = atan2(b(1), b(2));
%delta = (beta - gamma) * 180/pi
alpha = beta - gamma;

if alpha > pi
  alpha = 2*pi - alpha;
end

alpha_deg = alpha * 180/pi

%alpha = atan2(b(1) - a(1), b(2) - a(2));

%deg_alpha = alpha * 180/pi
%if abs(alpha) > 0.8
%plot(10 * cos(alpha) + new(2), 10 * sin(alpha) + new(1), 'bo');

line([new(1), 10 * cos(-gamma) + new(1)], [new(2), 10 * sin(gamma) + new(2)], 'Color', 'g');

%end

%alpha = acos(costheta);
%a = old(dimension) - new(dimension);
%c = sqrt((old(1) - new(1))^2 + (old(2) - new(2))^2)

%other_dimension = 3 - dimension;
%if direction == 1
  %alpha = pi - acos(a / c);
%  alpha = pi - real(asin(a / c));
%  if old(other_dimension) < new(other_dimension)
%    alpha = alpha * -1;
%  end
%else
  %alpha = acos(a / c);
%  alpha = real(asin(a / c));
%  if old(other_dimension) > new(other_dimension)
%    alpha = alpha * -1;
%  end
%end

if strcmp(environment, 'webots')
  V = 20;
else
  V = 1.5;
end


dt = 0.2;

if isnan(alpha)
  alpha = 0;
end

alpha
l_integral;
l_error = alpha / -pi;
l_integral = l_integral + (l_error*dt);
l_derivative = (l_error - previous_error / -pi)/dt;
l_output = (Kp* l_error) + (Ki*l_integral) + (Kd*l_derivative);

r_error = alpha / pi;
r_integral = r_integral + (r_error*dt);
r_derivative = (r_error - previous_error / pi)/dt;
r_output = (Kp*r_error) + (Ki*r_integral) + (Kd*r_derivative);

previous_error = alpha;

vl = V * (1 + l_output)
vr = V * (1 + r_output)

drivebot(vl, vr, 0.3);

end %  function



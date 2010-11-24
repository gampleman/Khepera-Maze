function pid(old, new, destination, dt)
%   PID   implements PID cotnrol for the robot
%      PID(POSITION_LAST_FRAME, POSITION_THIS_FRAME, DESTINATION, TIME_BETWEEN_FRAMES)
% 
%   PID control attempts to minimize the angle between the current 
%   heading and `destination` by driving the robot
%   
%   Created by Jakub Hampl on 2010-11-16.


global previous_error
global l_integral;
global r_integral;
global environment;

% setup constants based on environment
if strcmp(environment, 'webots')
  Kp = 1.0;   Ki = 0.05;  Kd = 0.1;
  V = 20;
else
  Kp = 1.0;   Ki = 0.01;     Kd = 0.25;
  V = 0.6;
end


a = new - old; % heading
b = destination - new; % desired heading

beta = atan2(-a(1), a(2));
gamma = atan2(-b(1), b(2));
alpha = beta - gamma;

% normalize vector to be -pi < alpha < pi
if alpha > pi
  alpha = alpha - 2*pi;
end
if alpha < -pi
  alpha = 2*pi + alpha;
end
if isnan(alpha)
  alpha = 0;
end

%beta_deg = beta * 180/pi
%gamma_deg = gamma * 180/pi
%alpha_deg = alpha * 180/pi


hold on;
line([new(2), 10 * cos(-atan2(b(1), b(2))) + new(2)], [new(1), 10 * sin(atan2(b(1), b(2))) + new(1)], 'Color', 'g');
drawnow

% pid for left wheel
l_error = alpha / -pi;
l_integral = l_integral + (l_error*dt);
l_derivative = (l_error - previous_error / -pi)/dt;
l_output = (Kp* l_error) + (Ki*l_integral) + (Kd*l_derivative);
% pid for rigth wheel
r_error = alpha / pi;
r_integral = r_integral + (r_error*dt);
r_derivative = (r_error - previous_error / pi)/dt;
r_output = (Kp*r_error) + (Ki*r_integral) + (Kd*r_derivative);

previous_error = alpha;

vl = V * (1 + l_output);
vr = V * (1 + r_output);

drivebot(vl, vr, 0);

end %  function



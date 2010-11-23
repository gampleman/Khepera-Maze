function drivebot(lspeed, varargin)
%DRIVEBOT Move the robot through the maze.
%
%   DRIVEBOT(Left speed, right speed, pause) Takes a different speed for
%   each wheel. This function can be used to turn the robot for a certain
%   pause time.
%
%   DRIVEBOT(speed, pause) Drive the robot at a certain speed for at least
%   the specified pause time.
%
%   DRIVEBOT(speed) Drive the robot at a certain speed.
switch length(varargin)
  case 2
    rspeed = varargin{1};
    pausetime = varargin{2};
  case 1
    rspeed = lspeed;
    pausetime = varargin{1};
  case 0
    rspeed = lspeed;
    pausetime = 0;
  otherwise
    error('drivebot:TooManyInputs requires at most 2 optional inputs');
end

if isnan(lspeed)
  pause(pausetime);
  return;
end   

if lspeed > 0
  lspeed = min(40, lspeed);
else
  lspeed = max(-40, lspeed);
end
  
if rspeed > 0
  rspeed = min(40, rspeed);
else
  rspeed = max(-40, rspeed);
end


% Inteligent rounding
%dif = round(abs(lspeed - rspeed));
%if lspeed > rspeed
%    rspeed = round(rspeed);
%    lspeed = rspeed + dif;
%else
%    lspeed = round(lspeed);
%    rspeed = lspeed + dif; 
%end
lspeed = round(lspeed);
rspeed = round(rspeed);
lspeed
rspeed
send_command(strcat('D,', num2str(lspeed), ',', num2str(rspeed)));
read_command; 
pause(pausetime);



function drivebot(lspeed, varargin)
%  DRIVEBOT(Left speed, right speed, pause)  
%  DRIVEBOT(speed, pause)  
%  DRIVEBOT(speed)  

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
  
    send_command(strcat('D,', num2str(round(lspeed)), ',', num2str(round(rspeed))));
    read_command; 

  pause(pausetime);

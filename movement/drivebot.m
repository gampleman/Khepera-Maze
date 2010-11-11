function drivebot(speed, varargin)
  numvarargs = length(varargin);
  
  if numvarargs > 1
      error('drivebot:TooManyInputs requires at most 1 optional input');
  end
  
  send_command(strcat('D,', num2str(speed), ',', num2str(speed)));
  read_command;
  
  if numvarargs
    pause(varargin{1});
  end

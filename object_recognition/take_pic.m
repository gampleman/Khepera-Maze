function I = take_snap()
%TAKE_SNAP Return an image of the scene. 
%
%   I = TAKESNAP() Depends on the enviroment the function returns an image 
%   from webot(simulator) or webcam(real world).
global environment;

if strcmp(environment, 'webots')
  string = sprintf('Z');
  send_command(string);
  read_command;
  pause(0.4);
  I = imread('/tmp/snapshot.ppm');
else
  unix(['mplayer tv:// -tv driver=v4l:width=640:height=480:', ...
  'device=/dev/video0 -frames 3 -vo jpeg &> /dev/null']);
  I = imread('00000003.jpg'); 
end

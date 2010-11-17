function I = take_snap()
% asks for the camera in the simulated world to capture a snapshot
global environment;
if strcmp(environment, 'webots')
string = sprintf('Z');
send_command(string);
read_command;
I = imread('/tmp/snapshot.ppm');
else
unix('mplayer tv:// -tv driver=v4l:width=640:height=480:device=/dev/video0 -frames 5 -vo jpeg &> /dev/null');
I = imread('00000003.jpg'); 
end

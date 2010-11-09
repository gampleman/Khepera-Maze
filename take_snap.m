function ret = take_snap()
% asks for the camera in the simulated world to capture a snapshot

string = sprintf('Z');
send_command(string);
ret = read_command;
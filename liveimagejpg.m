% capture a 640x480 jpg color image, store it in filename.jpg and return it
% Updated version: - tested on DICE RH9 12/10/04 with streamer from package
%                    xawtv-3.81-6
%                  - added stderr + stdout redirection to improve speed /
%                    remove text output to matlab shell at capture 
%                  - removed dependency on matlab image processing toolkit

function Im = liveimagejpg(filename)

  % use streamer command line application to capture an image to file 
  % see "man streamer" for details of streamer

% unix(['vidcat -d /dev/video0 -q 100 -s 640x480 > ', filename, '.jpg'])
% unix(['streamer -c /dev/video0 -j 90 -s 640x480 > ', filename, '.jpeg'])
%  unix(['streamer  -c /dev/video0 -j 90 -s 640x480 -o', filename, '.jpeg > /dev/null 2>&1'])
  unix(['mplayer tv:// -tv driver=v4l:width=640:height=480:device=/dev/video0 -frames 5 -vo jpeg > /dev/null 2>&1'])
  unix(['mv 00000005.jpg ', filename, '.jpg'])

  % read image from capture file
  % use importdata instead of imread to avoid needing 
  % image processing toolkit  
% Im = imread([filename, '.jpg'],'jpg'); 
% Im = imread([filename, '.jpeg'],'jpg'); 
  Im = importdata([filename, '.jpg'],'jpg'); 

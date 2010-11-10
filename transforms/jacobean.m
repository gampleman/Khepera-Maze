function outimage = jacobean(inimage, width, height, XY)
%   JACOBEAN   Does this bizzaro transfrom thing.
%     [IMAGE] = JACOBEAN(INIMAGE, UV, XY)
% 
%   Documentation? You betcha.
%   
%   Created by Jakub Hampl on 2010-11-03.


% An example of projective transfer

%UV=zeros(4,2);
%XY=zeros(4,2);
UV=[[30,30]',[30,width-30]',[height-30,width-30]',[height-30,30]']';    % target points
%XY=[[34,370]',[92,510]',[241,252]',[143,132]']';    % source points

P = esthomog(UV,XY,4);    % estimate homography mapping UV to XY

% get input image and sizes

[IR,IC, D]=size(inimage);
%dims = UV(3, :);
outimage=zeros(height, width, 3);   % destination image
v=zeros(3,1);

% loop over all pixels in the destination image, finding
% corresponding pixel in source image

for r = 1 : height
  for c = 1 : width
    v=P*[r,c,1]';        % project destination pixel into source
    y=round(v(1)/v(3));  % undo projective scaling and round to nearest integer
    x=round(v(2)/v(3));
    if (x >= 1) & (x <= IC) & (y >= 1) & (y <= IR)
      %outimage(r,c)=inimage(y,x);   % transfer colour
      outimage(r,c,:)=inimage(y,x,:);   % transfer color
    end
  end
end
outimage = outimage / 255;

end %  function


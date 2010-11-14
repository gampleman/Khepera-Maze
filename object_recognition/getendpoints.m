function [End, varargout] = getendpoints(I)
%   GETENDPOINTS   Gets the position of start and endpoint
%     [END, START] = GETENDPOINTS(I)
%     END = GETENDPOINTS(I)
%   Gets the ending and beginening points in the image
%   
%   Created by Jakub Hampl on 2010-11-10.

obj = getroundobjects(~im2bw(I, graythresh(I)), 0.6)

[w h] = size(obj);

[e, ind] = min(obj(3, :));
End = obj(1:2, ind);
obj(3, ind) = 100000;


if h == 6 && nargout == 2
  [e, ind] = min(obj(3, :));
  start = obj(1:2, ind);
  varargout{1} = start;
  obj(3, ind) = 100000;
end 

end %  function

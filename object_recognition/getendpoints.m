function [End, varargout] = getendpoints(I)
%GETENDPOINTS Gets the position of the endpoints
%
%   [END, START] = GETENDPOINTS(I) Retun both start and end points.
%   END = GETENDPOINTS(I) Return only end point.

obj = getroundobjects(~im2bw(I, graythresh(I)), 0.6)

[w h] = size(obj);

[e, ind] = min(obj(3, :));
End = obj(1:2, ind);
obj(3, ind) = 100000;

if h >= 6 && nargout == 2
  [e, ind] = min(obj(3, :));
  start = obj(1:2, ind);
  varargout{1} = start;
  obj(3, ind) = 100000;
end 

end %  function



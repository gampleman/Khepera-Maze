function I = nicetransform(I0, transformdims, corners)
%   NICETRANSFORM   Calls ptransform with a rotation as needed
%     [I] = NICETRANSFORM(I0, TRANFORM, CORNERS)
% 
%   
%   Created by Jakub Hampl on 2010-11-24.

I = ptransform(I0, transformdims(1), transformdims(2), corners);
if transformdims(1) < transformdims(2)
  I = imrotate(I, 90);
end

end %  function
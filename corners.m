function [top, right, b, left] = corners(Image)
%   CORNERS   Extracts corner coodrinates
%     [[TOP, RIGHT, BOTTOM, LEFT]] = CORNERS(IMAGE)
%     
%   
%   Created by Jakub Hampl on 2010-11-03.

[w, h] = size(Image);
for i=1:h
  a = find(Image(:, i) == 1);
  if(a > 0)
    left = [i a(1)];
    break
  end
end

for j=1:h
  i = h - j;
  a = find(Image(:, i) == 1);
  if(a > 0)
    right = [i a(1)];
    break
  end
end

for i=1:w
  a = find(Image(i, :) == 1);
  if(a > 0)
    top = [a(1) i];
    break
  end
end

for j=1:w
  i = w - j;
  a = find(Image(i, :) == 1);
  if(a > 0)
    b = [a(1) i];
    break 
  end
end

end %  function
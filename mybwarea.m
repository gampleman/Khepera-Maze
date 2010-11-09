% dependancy on matlab image proc. toolkit removed
% T. Breckon, 19/11/04

% returns an integer representing the number of non-black
% pixels in the image

% For a binary image this is equivalent to bwarea

function area = mybwarea(Image)
  nonBlack = find(Image>0);
  area = length(nonBlack);
  end
